//
//  InfoViewController.swift
//  SwiftUIApp
//
//  Created by Irina Semenova on 08/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let owner = User(name: "Denis", secondName: "Semenov", avatar: "msg")
        userName.text = owner.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
