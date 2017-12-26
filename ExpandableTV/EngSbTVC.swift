//
//  EngSbTVC.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

struct ExpandableEngagementData {
    var title: String
    var description: String
    var status: String
    var imageUrl: String
    var isEditable: Bool
    var engUID: Bool?
    
    init(title: String, description: String, status: String, imageUrl: String, isEditable: Bool) {
        self.title = title
        self.description = description
        self.status = status
        self.imageUrl = imageUrl
        self.isEditable = isEditable
    }
}

struct ExpandableEngagementSectionData {
    var isExpanded: Bool
    var expandableData: [ExpandableEngagementData]
    var numberOfRowsInSection: Int
    var engagementType: String
    var engagementNumber: Int
}

class EngSbTVC: BaseExpandableTVC {
    
    //MARK: - API
    func set(sectionDataSource: [ExpandableEngagementSectionData]) {
        sectionsDataSource = sectionDataSource
    }
    
    //MARK: - Properties
    //Var
    private var sectionsDataSource = [ExpandableEngagementSectionData]()
    //Constants
    private let engSBCellId = "engSBCell_ID"
    private let headerViewHeight = CGFloat(65)
    private let heightForRowAtIndexPath = CGFloat(65)
    private let lastRowInSectionShadowFix = CGFloat(15)
    private let lastSectionShadowFix = CGFloat(30)
    private let tintColor = UIColor(red:0.25, green:0.3, blue:0.72, alpha:1.0)
    private let firstSectionHeaderFixForAllElements = CGFloat(5)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseExpandableProperties()
        set(sectionDataSource: EngSbCell.getMocData())
        mapToExpandableListModel(sectionsDataSource: sectionsDataSource)
        setUI()
    }
    
    //MARK: - Helper
    private func setDataSource() {
        sectionsDataSource = EngSbCell.getMocData()
    }
    
    private func setBaseExpandableProperties() {
        baseSectionHeaderViewHeight = headerViewHeight
        setExpandableArrow(frame: CGRect(x: self.view.frame.width - 40, y: 25, width:10, height: 10), tint: .black)
    }
    
    private func mapToExpandableListModel(sectionsDataSource: [ExpandableEngagementSectionData]) {
        for expSection in sectionsDataSource {
            baseSectionsDataSource.append(BaseExpandableSectionData(isExpanded: expSection.isExpanded, numberOfRowsInSection: expSection.numberOfRowsInSection))
        }
    }
    
    private func setUI() {
        tableView.tintColor = tintColor
    }

    //MARK: - Actions
    override func handleExpandClose(button: UIButton) {
        super.handleExpandClose(button: button)
        
        tableView.reloadSections(IndexSet(integer: button.tag), with: .automatic)
    }
}

//MARK: - TableView Delegate and Datasource
extension EngSbTVC {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = super.tableView(tableView, viewForHeaderInSection: section)! as! BaseExpandableHeaderView
        headerView.setEngamentsExpandableHeader(section: section, sectionDataSource: sectionsDataSource[section], isExpanded: baseSectionsDataSource[section].isExpanded)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Fix for last section non-expanded state
        if (sectionsDataSource.count == section + 1), !baseSectionsDataSource[section].isExpanded {
            return headerViewHeight + lastSectionShadowFix
        }
        
        return section == 0 ? headerViewHeight + firstSectionHeaderFixForAllElements : headerViewHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sectionRows = baseSectionsDataSource[indexPath.section]
        
        //Last section shadow fix
        if sectionRows.numberOfRowsInSection == indexPath.row + 1 {
            //Last row in last section shadow fix
            if sectionsDataSource.count == indexPath.section + 1 {
                return heightForRowAtIndexPath + lastSectionShadowFix
            }
            
            return heightForRowAtIndexPath + lastRowInSectionShadowFix
        }
        
        return heightForRowAtIndexPath
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> EngSbCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: engSBCellId, for: indexPath) as! EngSbCell
        cell.delegate = self
        let expandableEngagementSectionData = sectionsDataSource[indexPath.section]
        cell.expandableEngagementData = expandableEngagementSectionData.expandableData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt__" + String(describing: indexPath))
    }
}

//MARK: - EngagementTabCellProtocol
extension EngSbTVC: EngagementTabCellProtocol {
    func editButtonTapped(indexPath: IndexPath) {
        print("didTapRowBtnAt__" + String(describing: indexPath))
    }
}
