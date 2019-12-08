
import UIKit

@IBDesignable class InfoShadowView: UIView {
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            //layer.shadowColor = newValue?.CGColor
            setNeedsDisplay()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = false
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor?.cgColor
    }
}

