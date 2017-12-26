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
        let indicatorFrame = (toggleArrow.frame != nil) ? toggleArrow.frame! : CGRect(x: frame.width - 30, y: 0, width:13, height: 13)
        
        let imgView = setExpandableArrowImageIndicator(arrowFrame: indicatorFrame, isExpanded: isSectionExpanded, arrowTint: arrowTint!, imgExpanded: toggleArrow.expandedImage, imgCollapsed: toggleArrow.collapsedImage)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
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

//MARK: - Expandable Engagement List
extension BaseExpandableHeaderView {
    
    //Computed constants
    var firstSectionHeaderFixForAllElements: CGFloat { return CGFloat(5) }
    var headerBackgroundRectHeight: CGFloat { return CGFloat(60) }
    var headerBackgroundRectXPadding: CGFloat { return CGFloat(10) }
    var blockingSectionsView: CGFloat { return CGFloat(40) }
    var blockingSectionsViewPadding: CGFloat { return CGFloat(20) }


    //API
    func setEngagementsExpandableListHeader(section: Int, sectionDataSource: ExpandableEngagementSectionData, isExpanded: Bool) {
        
        arrowTint = tintColor
        backgroundColor = .white
        
        let backgroundRect = UIView(frame: CGRect(x: headerBackgroundRectXPadding, y: 0, width: self.frame.width - 2*headerBackgroundRectXPadding, height: headerBackgroundRectHeight))
        UIView.setCustomShadow(mainView: self, shadowView: backgroundRect)
        if isExpanded {
            backgroundRect.frame.size.height = headerBackgroundRectHeight + 40
            backgroundRect.backgroundColor = .white
        }
        
        if isExpanded {
            let viewBlocker = UIView(frame: CGRect(x: 10, y: self.frame.height - blockingSectionsViewPadding, width: self.frame.width - blockingSectionsViewPadding, height: blockingSectionsView))
            viewBlocker.backgroundColor = .white
            self.addSubview(viewBlocker)
        }
        
        let backgroundRectCenterY = self.center.y - 11
        
        let engagementTypeLbl = setLabel(name: sectionDataSource.engagementType, xPos: CGFloat(30), yPos: backgroundRectCenterY, font: UIFont.boldSystemFont(ofSize: 15), txtColor: UIColor(red:0.13, green:0.15, blue:0.19, alpha:1))
        
        let _ = setLabel(name: String(sectionDataSource.engagementNumber), xPos: CGFloat(engagementTypeLbl.frame.origin.x + engagementTypeLbl.frame.size.width + 10), yPos: backgroundRectCenterY, font: UIFont.boldSystemFont(ofSize: 15), txtColor: UIColor(red:0.75, green:0.76, blue:0.77, alpha:1))
        
        
        if section == 0 {
            fixHeaderElementsForFirstSection()
        }
    }
    
    func setLabel(name: String, xPos: CGFloat, yPos: CGFloat, font: UIFont, txtColor: UIColor) -> UILabel {
        let lbl = UILabel()
        lbl.text = name
        lbl.textColor = txtColor
        lbl.textAlignment = .left
        lbl.font = font
        lbl.frame = CGRect(x:xPos, y:yPos,width:lbl.intrinsicContentSize.width,height:lbl.intrinsicContentSize.height)
        self.addSubview(lbl)
        return lbl
    }
    
    func fixHeaderElementsForFirstSection() {
        for v in self.subviews {
            v.frame.origin.y += firstSectionHeaderFixForAllElements
            self.bringSubview(toFront: v)
        }
    }
}
