import UIKit
import Kingfisher

class DarkknightViewController: UIViewController {

    var darkknightMovies:[Movie] = []
    
    @IBOutlet weak var familyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension DarkknightViewController: UICollectionViewDelegate {
    
}

extension DarkknightViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return darkknightMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DarkknightViewCell else { return UICollectionViewCell() }
        
        let movie = darkknightMovies[indexPath.row]
        let url = URL(string: movie.thumbnailPath)
        cell.thumbnailImage.kf.setImage(with: url)
        
        return cell
    }
    
    
}

extension DarkknightViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 144)
    }
}


class DarkknightViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
}


