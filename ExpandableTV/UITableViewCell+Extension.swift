//
//  UITableViewCell+Extension.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/26/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func setupCustomCellAppearance(layer: UIView) {
        layer.backgroundColor = UIColor.white
        layer.setLayerShadow(color: UIColor(red:0, green:0, blue:0, alpha:0.1), offset: CGSize(width: 0, height: 2), radius: 6)
        layer.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        contentView.addSubview(layer)
        contentView.sendSubview(toBack: layer)
    }
}
