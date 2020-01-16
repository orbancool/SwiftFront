import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        self.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let standartAnimation = AnimationTransition()
    
    let userLogin = "123"
    let userPassword = "123"
    
    func textFieldBorderStyle(field: UITextField, mask: CACornerMask) {
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        field.layer.maskedCorners = mask
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
    }

        


    
    override func viewDidLoad() {
        super.viewDidLoad()

        login.delegate = self
        password.delegate = self
        textFieldBorderStyle(field: login, mask: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        textFieldBorderStyle(field: password, mask: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
        
        

    }



    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        guard let _ = login.text,
              let _ = password.text else {
            return
        }
        
        if login.text == userLogin && password.text == userPassword {
            //performSegue(withIdentifier: "user", sender: sender)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MainTab")
            vc.modalPresentationStyle = .custom
            vc.modalPresentationCapturesStatusBarAppearance = true
            vc.transitioningDelegate = self
            present(vc, animated: true, completion: nil)
            return
        } else {
            vibrateEnter()
            showLoginError()
        }
    }
    
    func vibrateEnter() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func showLoginError() {
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }

    @IBAction func backToLogin(unwindSegue: UIStoryboardSegue){
        password.text = ""
        login.text = ""
    }
}


class AnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let to     = transitionContext.viewController(forKey: .to) else {
                return
        }
        transitionContext.containerView.addSubview(to.view)
        to.view.frame = CGRect(x: 0,//transitionContext.containerView.frame.width,
                               y: transitionContext.containerView.frame.height,
                               width: source.view.frame.width,
                               height: source.view.frame.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            source.view.frame = CGRect(x: 0,
                                       y: -source.view.frame.minY,
                                       width: source.view.frame.width,
                                       height: source.view.frame.height)
            to.view.frame = CGRect(x: 0,
                                   y: 0,
                                   width: source.view.frame.width,
                                   height: source.view.frame.height)
        }) { isCompleted in
            transitionContext.completeTransition(isCompleted)
        }
        
        
        /*UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            source.view.frame = CGRect(x: 0,
                                       y: -source.view.frame.minY,
                                       width: source.view.frame.width,
                                       height: source.view.frame.height)
            to.view.frame = CGRect(x: 0,
                                   y: 0,
                                   width: source.view.frame.width,
                                   height: source.view.frame.height)
        }) { isCompleted in
            transitionContext.completeTransition(isCompleted)
        }*/
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return standartAnimation
    }
}
