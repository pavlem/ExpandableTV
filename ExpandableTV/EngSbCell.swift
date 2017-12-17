//
//  EngSbCell.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit

class EngSbCell: UITableViewCell {

    @IBOutlet weak var titleOfEng: UILabel!
    @IBOutlet weak var backgroundRect: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCustomCellAppearance(layer: backgroundRect)
        
//        backgroundRect.backgroundColor = UIColor.white
//        backgroundRect.layer.shadowColor = UIColor.black.cgColor
//        backgroundRect.layer.shadowOpacity = 0.5
//        backgroundRect.layer.shadowOffset = CGSize(width: 0, height: 0)
//        backgroundRect.layer.shadowRadius = 2

//        self.layer.shadowColor = color.cgColor;
//        self.layer.shadowOffset = offset;
//        self.layer.shadowRadius = radius;
//        self.layer.shadowOpacity = 1;
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//            backgroundRect.setLayerShadow(color: UIColor.black, offset: CGSize(width: 5, height: 5), radius: 5)

    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
