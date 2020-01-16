import UIKit

class InfoViewController: UIViewController {

    
    @IBOutlet weak var collectionPhoto: UICollectionView!
    
    @IBOutlet weak var boxCollectionView: UICollectionView!
    
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        
        
        //boxCollectionView.backgroundColor = .green
        boxCollectionView.delegate = self
        boxCollectionView.dataSource = self
        //boxCollectionView.inse
        collectionPhoto.delegate = self
        collectionPhoto.dataSource = self
        collectionPhoto.backgroundColor = UIColor.clear
        collectionPhoto.layer.borderWidth = 1
        collectionPhoto.layer.borderColor = color.cgColor
        let owner = User(name: "Denis", secondName: "Semenov", avatar: "msg")
        userName.text = owner.name

    }
}
var library = [1,2,3,4,5,6,7,8,9,10]

extension InfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.boxCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "box", for: indexPath) as! boxCollectionViewCell
            let num = Int.random(in: 1...8)
            
            cell.boxPhoto.image = UIImage(named: "foto0" + String(num))
            
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! InfoCollectionViewCell
            let num = Int.random(in: 1...8)
            
            cell.photoLibrary.image = UIImage(named: "foto0" + String(num))
            
            
            return cell
        }

    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == boxCollectionView) {
            let frame = collectionView.frame
            let count = 3.0
            let offset: CGFloat = 2.0
            let spacing = CGFloat(count+1) * offset / CGFloat(count)
            let width = frame.width /  CGFloat(count)
            return CGSize(width: width, height: width)
        } else {
            //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! InfoCollectionViewCell
            return CGSize(width: 80, height: 80)
        }
        
    }
}
