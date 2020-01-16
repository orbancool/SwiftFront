import UIKit

class Indicator: UIView {
    
    var contentView: UIView!
    
    var changeWindow : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadFromXIB()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        let speed = 1/14.0
        let dotsLayer = createDots(dots: 14, radius: 20)
        for num in 0..<dotsLayer.count {
            
            contentView.layer.addSublayer(animDots(shape: dotsLayer[num], time: CACurrentMediaTime() + Double(num) * speed))
            
        }
        
        addSubview(contentView)
        
        //startAnimation()
    }

    func loadFromXIB() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return xib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    func createDots(dots dot: Int, radius rad: Int) -> [CAShapeLayer] {
        let center = CGSize(width: self.frame.width, height: self.frame.height)
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

    func startAnimation() {

        
    }


    func animDots(shape: CAShapeLayer, time: CFTimeInterval) -> CAShapeLayer {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 0.6
        fadeInAnimation.autoreverses = true
        fadeInAnimation.repeatCount = 5
        fadeInAnimation.beginTime = time + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        fadeInAnimation.fillMode = CAMediaTimingFillMode.both
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.997
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 5
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

    
}
