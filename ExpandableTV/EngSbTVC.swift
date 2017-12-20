//
//  EngSbTVC.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

struct ExpandableSBSectionData {
    var isExpanded: Bool
    var sectionRowTitles: [String]
    let headerTitle: String?
    var numberOfRowsInSection: Int
}

class EngSbTVC: BaseExpandableTVC {
    
    let engSBCellId = "engSBCell_ID"
    var sectionsDataSource = [ExpandableSBSectionData]()

    let headerViewHeight = CGFloat(65)
    let rowHeight = CGFloat(60)

    let headerBackgroundRectHeight = CGFloat(60)
    let headerBackgroundRectYPadding = CGFloat(10)
    let headerBackgroundRectXPadding = CGFloat(10)
//    let sectionFooterHeight = CGFloat(20)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set custom properties
        expandableSectionHeaderViewHeight = headerViewHeight
        setExpandableArrow(frame: CGRect(x: self.view.frame.width - 30, y: 20, width:13, height: 13), tint: .black)

        sectionsDataSource = [
            ExpandableSBSectionData(isExpanded: true, sectionRowTitles: ["Row - 00", "Row - 01", "Row - 02", "Row - 03", "Row - 04", "Row - 05"], headerTitle: "Section - 0", numberOfRowsInSection: ["Row - 00", "Row - 01", "Row - 02", "Row - 03", "Row - 04", "Row - 05"].count),
            ExpandableSBSectionData(isExpanded: true, sectionRowTitles: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"], headerTitle: "Section - 1", numberOfRowsInSection: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"].count),
            ExpandableSBSectionData(isExpanded: true, sectionRowTitles: ["Row - 20", "Row - 21", "Row - 22"], headerTitle: "Section - 2", numberOfRowsInSection: ["Row - 20", "Row - 21", "Row - 22"].count)
        ]

        for expSection in sectionsDataSource {
            baseSectionsDataSource.append(BaseExpandableSectionData(isExpanded: true, numberOfRowsInSection: expSection.numberOfRowsInSection))
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableCell(withIdentifier: "engSBHeaderCell_ID")!
        let headerView = super.tableView(tableView, viewForHeaderInSection: section)! as! BaseExpandableHeaderView
        
        headerView.backgroundColor = UIColor.white
        headerView.arrowTint = UIColor.black
        
        let backgroundRect = UIView(frame: CGRect(x: headerBackgroundRectXPadding, y: 0, width: self.view.frame.width - 2*headerBackgroundRectXPadding, height: headerBackgroundRectHeight))
        UIView.setCustomShadow(mainView: headerView, shadowView: backgroundRect)
        if baseSectionsDataSource[section].isExpanded {
            backgroundRect.frame.size.height = headerBackgroundRectHeight + 40
            backgroundRect.backgroundColor = .white
        }
        
        if baseSectionsDataSource[section].isExpanded {
            let viewBlocker = UIView(frame: CGRect(x: 10, y: headerView.frame.height - 20, width: self.view.frame.width - 20, height: 40))
            viewBlocker.backgroundColor = .white
            headerView.addSubview(viewBlocker)
        }
        
        let headerTitle = UILabel(frame: CGRect(x: 30, y: 15, width: self.view.frame.width, height: 20))
        headerTitle.text = sectionsDataSource[section].headerTitle
        headerView.addSubview(headerTitle)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let sectionRows = baseSectionsDataSource[indexPath.section]
        
        //Last cell in section - to show the shadow
        if sectionRows.numberOfRowsInSection == indexPath.row + 1 {
            return rowHeight + 15
        }
        
        return rowHeight
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
        let name = sectionsDataSource[indexPath.section].sectionRowTitles[indexPath.row]
        cell.titleOfEng?.text = name
        return cell
    }

    override func handleExpandClose(button: UIButton) {
        super.handleExpandClose(button: button)

        tableView.reloadSections(IndexSet(integer: button.tag), with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
