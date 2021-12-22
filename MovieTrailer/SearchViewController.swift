//
//  SearchViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/22.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        
        cell.resultLabel.text = "ddd"
        
        return cell
    }

}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var resultLabel: UILabel!
    
}
