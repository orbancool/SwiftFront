import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startView = Indicator()
        startView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(startView)
        
        startView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        startView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startView.translatesAutoresizingMaskIntoConstraints = false
        startAnimation()
        
        }
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "new")
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
}

/*class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let speed = 1/14.0
        let dotsLayer = createDots(dots: 14, radius: 20)
        for num in 0..<dotsLayer.count {

            view.layer.addSublayer(animDots(shape: dotsLayer[num], time: CACurrentMediaTime() + Double(num) * speed))

        }
        
        startAnimation()
    }
    
    func createDots(dots dot: Int, radius rad: Int) -> [CAShapeLayer] {
        let center = CGSize(width: view.frame.width, height: view.frame.height)
        let raduis = rad
        let dots = dot
        var theta = 0.0
        let step = (Double.pi * 2.0) / Double(dots)
        
        var dotsLayers = [CAShapeLayer]()
        for _ in 0..<dots {
            let posX = Double(center.width) * 0.5  + cos(theta) * Double(raduis)
            let posY = Double(center.height) * 0.5 + sin(theta) * Double(raduis)
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: posX, y: posY), radius: CGFloat(3), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.white.cgColor
            shapeLayer.opacity = 0
            dotsLayers.append(shapeLayer)
            theta += step
        }
        return dotsLayers
    }
    
    
    func animDots(shape: CAShapeLayer, time: CFTimeInterval) -> CAShapeLayer {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 0.6
        fadeInAnimation.autoreverses = true
        fadeInAnimation.repeatCount = 10
        fadeInAnimation.beginTime = time + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        fadeInAnimation.fillMode = CAMediaTimingFillMode.both
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.997
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 10
        pulse.initialVelocity = 0.6
        pulse.damping = 1
        pulse.beginTime = time + 1

        shape.add(fadeInAnimation, forKey: nil)
        //shape.add(pulse, forKey: nil)
        //
        //
        // вот тут не из центра скейл...
        //
        //
        return shape
    }

    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "new")
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        
    }
} */
