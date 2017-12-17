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
    }

}
