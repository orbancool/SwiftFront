import UIKit

class UILikeButton: UIButton {

    var likeCounts = Int.random(in: 0 ..< 100)

    var like: ((Bool) -> ())?
    
    var liked: Bool = false {
        didSet {
            if liked {
                setLike()
            } else {
                disLike()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultState()
        tap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultState()
        tap()
    }
    
    func defaultState() {
        setTitleColor(.gray, for: .normal)
        setTitle(String(describing: likeCounts), for: .normal)
        setImage(UIImage(named: "loveGray"), for: .normal)
        tintColor = .gray
        imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    func tap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    func setLike() {
        like?(true)
        pulse()
        setImage(UIImage(named: "loveRed"), for: .normal)
        tintColor = .red
        likeCounts += 1
        setTitle(String(describing: likeCounts), for: .normal)
    }
    
    func disLike() {
        like?(false)
        setImage(UIImage(named: "loveGray"), for: .normal)
        tintColor = .gray
        likeCounts -= 1
        setTitle(String(describing: likeCounts), for: .normal)
    }
    
    @objc func doubleTapped() {
        liked = !liked
    }
    
    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.25
        pulse.fromValue = 0.97
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}
extension UILikeButton {
    
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
    
}
/*
extension UILikeButton {
    override func layoutSubviews() {
        
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
}
 
 */

