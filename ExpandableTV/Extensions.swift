//
//  UIView+Extension.swift
//  Opi
//
//  Created by Veljko on 11/10/17.
//  Copyright © 2017 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowRadius = radius;
        self.layer.shadowOpacity = 1;
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    class func setCustomShadow(mainView: UIView, shadowView: UIView) {
        shadowView.backgroundColor = UIColor.white
        shadowView.setLayerShadow(color: UIColor(red:0, green:0, blue:0, alpha:1.0), offset: CGSize(width: 0, height: 2), radius: 3)
        shadowView.layer.cornerRadius = 2
        mainView.layer.masksToBounds = true
        mainView.addSubview(shadowView)
        mainView.sendSubview(toBack: shadowView)
    }
}

extension UITableViewCell {
    
    func setupCustomCellAppearance(layer: UIView) {
        layer.backgroundColor = UIColor.white
        layer.setLayerShadow(color: UIColor(red:0, green:0, blue:0, alpha:1.0), offset: CGSize(width: 0, height: 2), radius: 3)
        layer.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        contentView.addSubview(layer)
        contentView.sendSubview(toBack: layer)
    }
}