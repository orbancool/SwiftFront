import UIKit

class InfoTableView: UITableView {

    
    @IBOutlet weak var friendsImage: UIImageView!
    @IBOutlet weak var groupsImage: UIImageView!
    
    override init(frame: CGRect, style: UITableView.Style) {
        //
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        groupsImage.setImageColor(color: color)
        friendsImage.setImageColor(color: color)
        //friendsImage.tintColor = .red
        
        //groupsLabel.text = "test"
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}


