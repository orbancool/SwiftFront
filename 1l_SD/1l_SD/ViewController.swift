//
//  ViewController.swift
//  1l_SD
//
//  Created by Irina Semenova on 25/11/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2 * 0.5
    }
}

class ViewController: UIViewController {
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passField: UITextField!
    var vibrateMode = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.delegate = self
        passField.delegate = self
        
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func vibrateEnter() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        vibrateEnter()
        guard let log = loginField.text,
              let pass = passField.text else {
            return
        }
        print("login: \(log)\npassword: \(pass)")
    }
}

