//
//  BaseExpandableHeaderView.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/19/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit

protocol BaseExpandableHeaderViewDelegate: class {
    func handleExpandClose(button: UIButton)
}

class BaseExpandableHeaderView: UIView {
    
    //MARK: - API
    var arrowTint: UIColor? {
        didSet {
            for view in self.subviews where view is UIImageView {
                let imageView = view as! UIImageView
                imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = arrowTint
            }
        }
    }
    
    weak var delegate: BaseExpandableHeaderViewDelegate?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awakeFromNib")
    }
    
    //MARK: - Inits
    init(frame: CGRect, section: Int, toggleArrow: (frame: CGRect?, expandedImage: UIImage, collapsedImage: UIImage, tint: UIColor?)?, isSectionExpanded: Bool? = true) {
        
        super.init(frame: frame)

        tag = 200 + section
        backgroundColor = UIColor.lightGray
        
        if let toggleArrow = toggleArrow {
            let arrowTint = (toggleArrow.tint != nil) ? toggleArrow.tint : UIColor.blue

            let indicatorFrame = (toggleArrow.frame != nil) ? toggleArrow.frame! : CGRect(x: frame.width - 30, y: 10, width:13, height: 13)
            addSubview(UIImageView.setExpandableImageIndicator(arrowFrame: indicatorFrame, isExpanded: isSectionExpanded!, arrowTint: arrowTint!, imgExpanded: toggleArrow.expandedImage, imgCollapsed: toggleArrow.collapsedImage))
        }
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = frame
        
        addSubview(button)
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("handleExpandClose")
        delegate?.handleExpandClose(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
