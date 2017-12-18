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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set custom properties
        expandableSectionHeaderViewHeight = CGFloat(60)
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
        let headerView = super.tableView(tableView, viewForHeaderInSection: section)!
        
        headerView.backgroundColor = UIColor.white
        
        let backgroundRect = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: 40))
        UIView.setCustomShadow(mainView: headerView, shadowView: backgroundRect)
        if baseSectionsDataSource[section].isExpanded {
            backgroundRect.frame.size.height = 70
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let sectionRows = baseSectionsDataSource[indexPath.section]
        
        //Last cell in section - to show the shadow
        if sectionRows.numberOfRowsInSection == indexPath.row + 1 {
            return 100
        }
        
        return 60
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
    
    override func toggleHeaderSection(section: Int) {
        super.toggleHeaderSection(section: section)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }


    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if !twoDimensionalArray[section].isExpanded {
//            return nil
//        }
//        let sectionFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
//        sectionFooterView.backgroundColor = UIColor.orange
//
//
//        let backView = UIView(frame: CGRect(x: 10, y: -10, width: self.view.frame.width - 20, height: 20))
//        backView.backgroundColor = UIColor.clear
//        backView.setLayerShadow(color: UIColor.black, offset: CGSize(width: 3, height: 5), radius: 5)
//
//        sectionFooterView.addSubview(backView)
//
//
//        return sectionFooterView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
//    override func toggleHeaderSection(section: Int) {
//        super.toggleHeaderSection(section: section)
//        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//    }
}
