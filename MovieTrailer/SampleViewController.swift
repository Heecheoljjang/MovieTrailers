//
//  SampleViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/21.
//

import UIKit

class SampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SampleViewController: UICollectionViewDelegate {
    
}

extension SampleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SampleViewCell else { return UICollectionViewCell() }
        
        cell.thumbnailImage.image = UIImage(systemName: "pencil")
        
        return cell
    }
    
    
}

extension SampleViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 144)
    }
}

class SampleViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
}
