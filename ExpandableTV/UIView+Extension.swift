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
}

extension UIView {
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

extension UIView {
    
    public func addConstaintsToSuperview(rightOffset: CGFloat, topOffset: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: rightOffset).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }
    
    public func addConstaintsToSuperview(leftOffset: CGFloat, topOffset: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leftOffset).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }
    
    public func addConstaints(height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
        
        
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
}
