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
    
    //MARK: - Inits
    init(frame: CGRect, section: Int, toggleArrow: (frame: CGRect?, expandedImage: UIImage, collapsedImage: UIImage, tint: UIColor?)?, isSectionExpanded: Bool? = true) {
        super.init(frame: frame)

        tag = 200 + section
        backgroundColor = UIColor.lightGray
        
        if let toggleArrow = toggleArrow {
            addHeaderToggleArrowImage(toggleArrow: toggleArrow, isSectionExpanded: isSectionExpanded!)
        }
        addHeaderToggleButton(tableHeaderSection: section)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awakeFromNib")
    }
    
    //MARK: - Helper
    private func addHeaderToggleArrowImage(toggleArrow: (frame: CGRect?, expandedImage: UIImage, collapsedImage: UIImage, tint: UIColor?), isSectionExpanded: Bool) {
        
        let arrowTint = (toggleArrow.tint != nil) ? toggleArrow.tint : UIColor.blue
        let indicatorFrame = (toggleArrow.frame != nil) ? toggleArrow.frame! : CGRect(x: frame.width - 30, y: 10, width:13, height: 13)
        let imgView = setExpandableArrowImageIndicator(arrowFrame: indicatorFrame, isExpanded: isSectionExpanded, arrowTint: arrowTint!, imgExpanded: toggleArrow.expandedImage, imgCollapsed: toggleArrow.collapsedImage)
        addSubview(imgView)
    }

    private func addHeaderToggleButton(tableHeaderSection: Int) {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = tableHeaderSection
        button.frame = frame
        addSubview(button)
    }
    
    func setExpandableArrowImageIndicator(arrowFrame: CGRect, isExpanded: Bool, arrowTint tint: UIColor, imgExpanded: UIImage, imgCollapsed: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: arrowFrame)
        imageView.contentMode = .center
        imageView.image = isExpanded ? imgExpanded : imgCollapsed
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tint
        return imageView
    }
    
    //MARK: - Actions
    @objc func handleExpandClose(button: UIButton) {
        print("handleExpandClose")
        delegate?.handleExpandClose(button: button)
        
        
    }
}
