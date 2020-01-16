import UIKit

class newButton: UILikeButton {
    override func disLike() {
        configureColorLike()
    }
    
    override func defaultState() {
        super.defaultState()
        configureColorLike()
        
    }
    
    func configureColorLike() {
        let img = UIImage(named: "loveRed")?.withRenderingMode(.alwaysTemplate)
        self.setImage(img, for: .normal)
        self.tintColor = .white
    }
}

class GruopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoInGroup: ScaleImage!
    @IBOutlet weak var loveButton: newButton!

}
