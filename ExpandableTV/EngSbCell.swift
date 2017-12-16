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
        
//        backgroundRect.layer.shadowColor = UIColor.black.cgColor
//        backgroundRect.layer.shadowOpacity = 1
//        backgroundRect.layer.shadowOffset = CGSize.zero
//        backgroundRect.layer.shadowRadius = 20
        backgroundRect.setLayerShadow(color: UIColor.black, offset: CGSize(width: 6, height: 5), radius: 1)

    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
