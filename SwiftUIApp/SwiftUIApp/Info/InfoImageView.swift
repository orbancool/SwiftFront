//
//  InfoImageView.swift
//  SwiftUIApp
//
//  Created by Irina Semenova on 08/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

@IBDesignable class InfoImageView: UIImageView {
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true

    }

}
