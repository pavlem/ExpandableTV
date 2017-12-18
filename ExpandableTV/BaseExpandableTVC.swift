//
//  BaseExpandableTVC.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/17/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

struct BaseExpandableSectionData {
    var isExpanded: Bool
    var numberOfRowsInSection: Int
}

class BaseExpandableTVC: UITableViewController {

    //MARK: - API
    var baseSectionsDataSource = [BaseExpandableSectionData]()
    var expandableSectionHeaderViewHeight = CGFloat(46)

    func setExpandableArrow(frame: CGRect?, tint: UIColor) {
        isExpandableArrowShown = true
        expandableArrowIndicatorFrame = frame
        expandableArrowIndicatorTintColour = tint
    }
    
    //MARK: - Properties
    // Vars
    private var isExpandableArrowShown = false
    private var expandableArrowIndicatorFrame: CGRect?
    private var expandableArrowIndicatorTintColour = UIColor.black
    private var titleOpen: String?
    private var titleClose: String?
    //Constants
    let baseEexpandableCellId = "baseExpandableCell_ID"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: baseEexpandableCellId)
    }
    
    //MARK: - Actions
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        let isSectionexpanded = baseSectionsDataSource[section].isExpanded
        
        var indexPaths = [IndexPath]()
        
        let rows = Array(0...baseSectionsDataSource[section].numberOfRowsInSection - 1)
        for row in rows {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        baseSectionsDataSource[section].isExpanded = !isSectionexpanded
        
        button.setTitle(isSectionexpanded ? titleOpen : titleClose, for: .normal)
        
        if isSectionexpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
//        tableView.reloadSections([section], with: .automatic) //This option is also possible but then arrow animation expand/collapse is not shown because of the header reload
        toggleHeaderSection(section: section)
    }
    
    func toggleHeaderSection(section: Int) {
        let hView = tableView.viewWithTag(200 + section)
        for imageView in hView!.subviews where (imageView is UIImageView) {
            UIView.animate(withDuration: 0.2) {
                imageView.transform = imageView.transform.rotated(by: self.baseSectionsDataSource[section].isExpanded ? .pi/2 : -.pi/2)
            }
        }
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(expandableSectionHeaderViewHeight)))
        hView.tag = 200 + section
        hView.backgroundColor = UIColor.orange
        
        if isExpandableArrowShown {
            let indicatorFrame = (expandableArrowIndicatorFrame != nil) ? expandableArrowIndicatorFrame! : CGRect(x: self.view.frame.width - 30, y: 10, width:13, height: 13)
            hView.addSubview(UIImageView.setExpandableImageIndicator(arrowFrame: indicatorFrame, isExpanded: baseSectionsDataSource[section].isExpanded, arrowTint: expandableArrowIndicatorTintColour, imgExpanded: #imageLiteral(resourceName: "Down"), imgCollapsed: #imageLiteral(resourceName: "Right")))
        }
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = hView.frame
        
        hView.addSubview(button)
        
        return hView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return expandableSectionHeaderViewHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return baseSectionsDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !baseSectionsDataSource[section].isExpanded {
            return 0
        }
        
        return baseSectionsDataSource[section].numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
