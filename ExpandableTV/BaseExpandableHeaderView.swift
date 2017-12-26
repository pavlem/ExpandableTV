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

    //API
    func setEngamentsExpandableHeader(section: Int, sectionDataSource: ExpandableEngagementSectionData, isExpanded: Bool) {
        
        self.backgroundColor = UIColor.white
        self.arrowTint = tintColor
        
        let backgroundRect = UIView(frame: CGRect(x: headerBackgroundRectXPadding, y: 0, width: self.frame.width - 2*headerBackgroundRectXPadding, height: headerBackgroundRectHeight))
        UIView.setCustomShadow(mainView: self, shadowView: backgroundRect)
        if isExpanded {
            backgroundRect.frame.size.height = headerBackgroundRectHeight + 40
            backgroundRect.backgroundColor = .white
        }
        
        if isExpanded {
            let viewBlocker = UIView(frame: CGRect(x: 10, y: self.frame.height - 20, width: self.frame.width - 20, height: 40))
            viewBlocker.backgroundColor = .white
            self.addSubview(viewBlocker)
        }
        
        let backgroundRectCenterY = self.center.y - 11
        
        let headerTitle = UILabel()
        headerTitle.text = sectionDataSource.engagementType
        headerTitle.backgroundColor = .red
        headerTitle.textColor = UIColor(red:0.13, green:0.15, blue:0.19, alpha:1)
        headerTitle.textAlignment = .left
        headerTitle.font = UIFont.boldSystemFont(ofSize: 15)
        headerTitle.frame = CGRect(x:30, y:backgroundRectCenterY,width:headerTitle.intrinsicContentSize.width,height:headerTitle.intrinsicContentSize.height)
        self.addSubview(headerTitle)
        
        let engNumber = UILabel()
        engNumber.text = String(sectionDataSource.engagementNumber)
        engNumber.backgroundColor = .orange
        engNumber.textColor = UIColor(red:0.75, green:0.76, blue:0.77, alpha:1)
        engNumber.textAlignment = .left
        engNumber.font = UIFont.boldSystemFont(ofSize: 15)
        let engNumberFr = headerTitle.frame.origin.x + headerTitle.frame.size.width + 10
        engNumber.frame = CGRect(x:engNumberFr,y:backgroundRectCenterY,width:engNumber.intrinsicContentSize.width,height:engNumber.intrinsicContentSize.height)
        self.addSubview(engNumber)
        
        if section == 0 {
            fixHeaderElementsForFirstSection()
        }
    }
    
    func fixHeaderElementsForFirstSection() {
        for v in self.subviews {
            v.frame.origin.y += firstSectionHeaderFixForAllElements
            self.bringSubview(toFront: v)
        }
    }
}
