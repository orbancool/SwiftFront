//
//  SettingsProfileList.swift
//  2l_SD
//
//  Created by Irina Semenova on 01/12/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit

class SettingsProfileList: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //self.selectedBackgroundView = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)

        
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        //let bgColorView = UIView()
        //bgColorView.backgroundColor =  .gray
        //self.selectedBackgroundView = bgColorView
        
    }
    

}
