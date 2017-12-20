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

struct ToggleArrow {
    let frame: CGRect?
    let expandedImage: UIImage
    let collapsedImage: UIImage
    let tint: UIColor?
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
    
    //MARK: - Properties
    private var isToggleArrowShown: Bool {
        for view in self.subviews where view is UIImageView {
            return true
        }
        
        return false
    }
    
    private var isExpanded = false
    
    //MARK: - Inits
    init(frame: CGRect, section: Int, toggleArrow: ToggleArrow?, isSectionExpanded: Bool? = true) {
        super.init(frame: frame)

        isExpanded = isSectionExpanded!
        
        tag = 200 + section
        
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
        
        print("awakeFromNib - only for SB Instantiation")
    }
    
    //MARK: - Helper
    private func addHeaderToggleArrowImage(toggleArrow: ToggleArrow, isSectionExpanded: Bool) {
        let arrowTint = (toggleArrow.tint != nil) ? toggleArrow.tint : UIColor.blue
        let indicatorFrame = (toggleArrow.frame != nil) ? toggleArrow.frame! : CGRect(x: frame.width - 30, y: 10, width:13, height: 13)
        let imgView = setExpandableArrowImageIndicator(arrowFrame: indicatorFrame, isExpanded: isSectionExpanded, arrowTint: arrowTint!, imgExpanded: toggleArrow.expandedImage, imgCollapsed: toggleArrow.collapsedImage)
        addSubview(imgView)
    }

    private func setExpandableArrowImageIndicator(arrowFrame: CGRect, isExpanded: Bool, arrowTint tint: UIColor, imgExpanded: UIImage, imgCollapsed: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: arrowFrame)
        imageView.contentMode = .center
        imageView.image = isExpanded ? imgExpanded : imgCollapsed
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tint
        return imageView
    }
    
    private func addHeaderToggleButton(tableHeaderSection: Int) {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = tableHeaderSection
        button.frame = frame
        addSubview(button)
    }
    
    private func rotateArrowIndicator(isExpanded: Bool) {
        for imageView in self.subviews where imageView is UIImageView {
            UIView.animate(withDuration: 0.2) {
                imageView.transform = imageView.transform.rotated(by: isExpanded ? .pi/2 : -.pi/2)
            }
        }
    }
    
    //MARK: - Actions
    @objc func handleExpandClose(button: UIButton) {
        isExpanded = !isExpanded
        
        if isToggleArrowShown {
            rotateArrowIndicator(isExpanded: self.isExpanded)
        }
        
        delegate?.handleExpandClose(button: button)
    }
}
