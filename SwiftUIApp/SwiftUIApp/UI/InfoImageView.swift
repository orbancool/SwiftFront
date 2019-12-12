import UIKit

@IBDesignable class InfoImageView: UIImageView {
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }

}
