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

class BaseExpandableTVC: UITableViewController, BaseExpandableHeaderViewDelegate {
    
    //MARK: - API
    var baseSectionsDataSource = [BaseExpandableSectionData]()
    var expandableSectionHeaderViewHeight = CGFloat(46)
    
    func setExpandableArrow(frame: CGRect, tint: UIColor) {
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
        button.setTitle(baseSectionsDataSource[button.tag].isExpanded ? titleOpen : titleClose, for: .normal)
        deleteOrInsertRows(forSection: button.tag)
    }
    
    //MARK: - Helper
    private func deleteOrInsertRows(forSection section: Int) {
        let isSectionexpanded = baseSectionsDataSource[section].isExpanded
        var indexPaths = [IndexPath]()
        
        let rows = Array(0...baseSectionsDataSource[section].numberOfRowsInSection - 1)
        for row in rows {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        baseSectionsDataSource[section].isExpanded = !isSectionexpanded
        
        if isSectionexpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

//MARK: - UITableViewDelegate
extension BaseExpandableTVC {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerFrame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(expandableSectionHeaderViewHeight))
        let hView = BaseExpandableHeaderView(frame: headerFrame, section: section, toggleArrow: isExpandableArrowShown ? ToggleArrow(frame: expandableArrowIndicatorFrame!, expandedImage: #imageLiteral(resourceName: "Down"), collapsedImage: #imageLiteral(resourceName: "Right"), tint: expandableArrowIndicatorTintColour) : nil, isSectionExpanded: baseSectionsDataSource[section].isExpanded)
        hView.delegate = self
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
