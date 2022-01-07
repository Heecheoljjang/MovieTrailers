//
//  ViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if titleLabel.adjustsFontSizeToFitWidth == false {
            titleLabel.adjustsFontSizeToFitWidth = true
        }
        
        Avengers.sample { movies in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            DispatchQueue.main.async {
                let vc = sb.instantiateViewController(withIdentifier: "Avengers") as! AvengersViewController
                self.present(vc, animated: false, completion: nil)
                
                vc.avengersMovies = movies
                print(vc.avengersMovies.count)
                
            }
        }
        
        DispatchQueue.main.async {
            FamilyMovie.family { movies in
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "Family") as? FamilyViewController

                vc?.familyMovies = movies
            }
        }
        
    }
    
}

//Action이었지만 previewURL이 없는 것들이 있어 Avengers로 바꿈
class Avengers {
    
    static func sample(completion: @escaping ([Movie]) -> Void) {
        
        let session = URLSession(configuration: .default)
        var urlComponent = URLComponents(string: "https://itunes.apple.com/search?")

        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: "Avengers")

        urlComponent?.queryItems?.append(mediaQuery)
        urlComponent?.queryItems?.append(entityQuery)
        urlComponent?.queryItems?.append(termQuery)
        
        guard let requestURL = urlComponent?.url else { return }
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                completion([])
                return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let movies = Avengers.parsingData(resultData)
            completion(movies)
        }
        dataTask.resume()
        
    }
    static func parsingData(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            
            return movies
        }catch let DecodingError.dataCorrupted(context) {
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

//Family였지만 previewURL이 없는 것들이 있어 Dark Knight로 바꿈
class DarkKnight {
    static func sample(completion: @escaping ([Movie]) -> Void) {
        
        let session = URLSession(configuration: .default)
        var urlComponent = URLComponents(string: "https://itunes.apple.com/search?")

        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: "dark-knight")

        urlComponent?.queryItems?.append(mediaQuery)
        urlComponent?.queryItems?.append(entityQuery)
        urlComponent?.queryItems?.append(termQuery)
        
        guard let requestURL = urlComponent?.url else { return }
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                completion([])
                return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let movies = DarkKnight.parsingData(resultData)
            completion(movies)
        }
        dataTask.resume()
        
    }
    static func parsingData(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            
            return movies
        }catch let DecodingError.dataCorrupted(context) {
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

