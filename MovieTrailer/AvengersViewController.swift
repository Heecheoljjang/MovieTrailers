//
//  SampleViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/21.
//

import UIKit
import Kingfisher

class AvengersViewController: UIViewController {

    var avengersMovies:[Movie] = []
    

    @IBOutlet weak var avengersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AvengersViewController: UICollectionViewDelegate {
    
}

extension AvengersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avengersMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AvengersViewCell else { return UICollectionViewCell() }
        
        let movie = avengersMovies[indexPath.row]
        let url = URL(string: movie.thumbnailPath)
        
        
        cell.thumbnailImage.kf.setImage(with: url)
//        cell.thumbnailImage.image = UIImage(systemName: "pencil")
        return cell
    }
    
    
}

extension AvengersViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 144)
    }
}


class AvengersViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
}


