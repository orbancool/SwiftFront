//
//  userInfo.swift
//  2l_SD
//
//  Created by Irina Semenova on 03/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import Foundation
import UIKit


class User {
    var name: String
    var secondName: String
    var avatar: UIImage?
    var photo: UIImageView?
    
    init(name: String, secondName: String, avatar: UIImage) {
        self.name = name
        self.secondName = secondName
        self.avatar = avatar
    }
    
    init(name: String, secondName: String, photo: UIImageView) {
        self.name = name
        self.secondName = secondName
        self.photo = photo
    }
}
