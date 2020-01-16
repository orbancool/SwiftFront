import UIKit

class ScaleImage: UIImageView {
    var tempRect: CGRect?
    var bgView: UIView!

    var animated: Bool = true
    var intDuration = 0.25
    //MARK: Life cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScaleImage.popUpImageToFullScreen))
        self.addGestureRecognizer(tapGesture)
        
        
        
        self.isUserInteractionEnabled = true
        
        
        //        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swipe() {
        print("swipe")
        //nextPic!()
    }
    //MARK: Actions of Gestures
    @objc func exitFullScreen () {
        let imageV = bgView.subviews[0] as! UIImageView
        UIView.animate(withDuration: intDuration, animations: {
            imageV.frame = self.tempRect!
            self.bgView.alpha = 0
        }, completion: { (bol) in
            self.bgView.removeFromSuperview()
        })
    }
    
    @objc func popUpImageToFullScreen() {
        
        if let window = UIApplication.shared.delegate?.window {
            let parentView = self.findParentViewController(self)!.view
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe))
            
            
            bgView = UIView(frame: UIScreen.main.bounds)
            bgView.addGestureRecognizer(swipe)
            bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ScaleImage.exitFullScreen)))
            bgView.alpha = 0
            bgView.backgroundColor = UIColor.black
            let imageV = UIImageView(image: self.image)
            
            let point = self.convert(self.bounds, to: parentView)
            imageV.frame = point
            
            //imageV = UIImageView(image: UIImage(named: "foto01"))
            tempRect = point
            imageV.contentMode = .scaleAspectFit
            self.bgView.addSubview(imageV)
            
            window?.addSubview(bgView)
            
            if animated {
                UIView.animate(withDuration: intDuration, animations: {
                    self.bgView.alpha = 1
                    imageV.frame = CGRect(x: 0, y: 0, width: (parentView?.frame.width)!, height: (parentView?.frame.width)!)
                    imageV.center = (parentView?.center)!
                })
            }
        }
    }
    
    func findParentViewController(_ view: UIView) -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
