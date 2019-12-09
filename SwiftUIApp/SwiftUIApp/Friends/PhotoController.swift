import UIKit

private let reuseIdentifier = "ident"

class PhotoController: UICollectionViewController {
    
    var photoCollection = [1,3,4,5,6,7,8,0,1,2,3,4,5,6,7,7,8,6,4,3,4,4,3,23,4,4,5,5,5,5,6,5]
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        //cell.loveButton.setLikeCount = Int.random(in: 0 ..< 100)
        return cell
    }
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var loveButton: UILikeButton!

}
