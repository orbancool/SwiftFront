//
//  FriendsImage.swift
//  2l_SD
//
//  Created by Irina Semenova on 01/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

class FriendsImage: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        //layer.cornerRadius = 10
        //self.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}