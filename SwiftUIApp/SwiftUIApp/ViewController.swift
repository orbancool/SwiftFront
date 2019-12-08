//
//  ViewController.swift
//  2l_SD
//
//  Created by Irina Semenova on 27/11/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = bounds.height / 2 * 0.5
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
            performSegue(withIdentifier: "user", sender: sender)
            //print("login: \(userLogin), passowrd: \(userPassword)")
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
