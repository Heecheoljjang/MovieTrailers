//
//  SearchViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/22.
//

import UIKit
import Kingfisher
import Firebase

class SearchViewController: UIViewController {
    @IBOutlet weak var searchHistory: UITableView!
    
    let db = Database.database().reference().child("searchHistory")
    var searchTerms: [SearchTerm] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        db.observeSingleEvent(of: .value) { snapshot in
            guard let searchHistory = snapshot.value as? [String: Any] else { return } //key를 제외한 value값만 보기위해
            let datas = Array(searchHistory.values)
            let decoder = JSONDecoder()
            
            
            let data = try! JSONSerialization.data(withJSONObject: datas, options: [])//JSON형태로 만들어줌
            let searchTerms = try! decoder.decode([SearchTerm].self, from: data)
            
            self.searchTerms = searchTerms.sorted(by: { (term1, term2) in
                return term1.timestamp > term2.timestamp
            })
            self.searchHistory.reloadData()
            print("\(data), \(searchTerms)")

        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        
        cell.resultLabel.text = searchTerms[indexPath.row].term
        
        return cell
    }

}

extension SearchViewController: UITableViewDelegate {
    
}

//SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        //search 했을때 ResultView를 띄우기위해
        let sb = UIStoryboard(name: "Result", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ResultView") as! ResultViewController
        vc.modalPresentationStyle = .fullScreen
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else {return}
        
        self.present(vc, animated: true, completion: nil)
        
        vc.searchLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        vc.searchLabel.text = searchTerm
        
        
        SearchAPI.search(searchTerm) { movies in
            DispatchQueue.main.async {
                vc.movies = movies
                print(vc.movies.count)
                vc.resultCollectionView.reloadData()
                
                let timestamp:Double = Date().timeIntervalSince1970.rounded()
                self.db.childByAutoId().setValue(["term": searchTerm, "timestamp": timestamp])
            }
        }
        
        
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var resultLabel: UILabel!
}

class SearchAPI {
    static func search(_ searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: searchTerm)
        
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        guard let requestURL = urlComponents.url else { return  }

        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in // 세가지가 내려옴
            let successRange = 200..<300
            
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                      completion([]) //제대로된 데이터가 없다.
                      return
                  } //성공적으로 response가 왔는지
            
            guard let resultData = data else {
                completion([])
                return
            }
            //print(resultData)
            
            //data를 파싱해서 [Movie]로 해줌
//            let string = String(data: resultData, encoding: .utf8)
//            print(string)
            
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
        }
        dataTask.resume()
    }
    //파싱하기
    static func parseMovies(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do{
            let response = try decoder.decode(Response.self, from: data) //될지 안될지 모르기때문에 try
            let movies = response.movies
            print("good")
            return movies
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return []
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return []

        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return []

        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return []

        } catch {
            print("error: ", error)
            return []

        }
    }
}

struct Response: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}
struct Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let trailerURL: String
    let genre: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case trailerURL = "previewUrl"
        case genre = "primaryGenreName"
    }
}

struct SearchTerm: Codable {
    let term: String
    let timestamp: Double
}
