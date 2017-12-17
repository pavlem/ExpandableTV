//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by Brian Voong on 11/13/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

struct ExpandableHeaderTitles {
    static let open = "open"
    static let close = "close"
}

class ExpandableTVC: BaseExpandableTVC {
    
    //Constants
    let expandableCellId = "expandableCell_ID"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionsDataSource = [
            ExpandableSectionData(isExpanded: true, sectionTitles: ["Row - 01", "Row - 02", "Row - 03", "Row - 04"], headerTitle: "Section - 0"),
            ExpandableSectionData(isExpanded: true, sectionTitles: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"], headerTitle: "Section - 1"),
            ExpandableSectionData(isExpanded: true, sectionTitles: ["Row - 20", "Row - 21"], headerTitle: "Section - 2"),
            ExpandableSectionData(isExpanded: true, sectionTitles: ["Row - 30", "Row - 31", "Row - 32", "Row - 33"], headerTitle: "Section - 3"),
            ExpandableSectionData(isExpanded: true, sectionTitles: ["Row - 40", "Row - 41", "Row - 42"], headerTitle: "Section - 4")
        ]
        
        setHeaderTotggleBtnTitle(open: ExpandableHeaderTitles.open, close: ExpandableHeaderTitles.close)
        
//        tableView.register(ExpandableCell.self, forCellReuseIdentifier: expandableCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: expandableCellId)

    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: baseEexpandableCellId, for: indexPath) as! ExpandableCell
//        let name = sectionsDataSource[indexPath.section].sectionTitles[indexPath.row]
//        cell.textLabel?.text = name
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: baseEexpandableCellId, for: indexPath)
        let name = sectionsDataSource[indexPath.section].sectionTitles[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }

}
