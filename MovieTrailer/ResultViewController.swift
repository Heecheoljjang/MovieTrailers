//
//  ResultViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2021/12/22.
//

import UIKit
import Kingfisher
import AVFoundation

class ResultViewController: UIViewController {

    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        let url = URL(string: movie.trailerURL)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Player") as! PlayerViewController
        
        vc.player.replaceCurrentItem(with: item)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    
    }
}

extension ResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ResultCell else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.row]
        let url = URL(string: movie.thumbnailPath)
        cell.thumbnailImage.kf.setImage(with: url)
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
}

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 10
        let spacing: CGFloat = 15
        let width: CGFloat = (collectionView.bounds.width - 2 * margin - spacing) / 2
        let height: CGFloat = width * 10 / 7
        
        return CGSize(width: width, height: height)
        
    }
}

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
}
