import UIKit

class AvaratImage: UIImageView {
    
    var like = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let color = UIColor(displayP3Red: 0.496, green: 0.591, blue: 0.799, alpha: 1)
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = color.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        tap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tap()
    }
    
    func switchLike() {
        like.toggle()
        like ? print("like") : print("dislike")
        
    }
    
    func tap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    @objc func singleTapped() {
        springImageAnim()
        switchLike()
    }
    
    func springImageAnim() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 1
        animation.duration = 2
        animation.damping = 10
        //animation.fillMode = .both
        self.layer.add(animation, forKey: nil)
    }
    
}
