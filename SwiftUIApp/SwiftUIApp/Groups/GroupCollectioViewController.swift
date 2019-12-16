import UIKit

private let reuseIdentifier = "ident"

class GroupCollectioViewController: UICollectionViewController {
    
    var photoCollection = [1,3,4,5,6,7,8,0,1,2,3,4,5,6,7,7,8,6,4,3,4,4,3,23,4,4,5,5,5,5,6,5]
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //update()
    }
    
    func update() {
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GruopCollectionViewCell
        
        return cell
    }
    
}


