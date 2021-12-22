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
    }
}

