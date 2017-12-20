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

var expDataSource = [[String]]()

class ExpandableTVC: BaseExpandableTVC {
    
    //Constants
    let expandableCellId = "expandableCell_ID"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expDataSource = [
            ["P=Row - 00", "P=Row - 01", "P=Row - 02", "P=Row - 03"],
            ["P=Row - 10", "P=Row - 11", "P=Row - 12", "P=Row - 13", "P=Row - 14"],
            ["P=Row - 20", "P=Row - 21", "P=Row - 22", "P=Row - 23", "P=Row - 24", "P=Row - 25"],
            ["P=Row - 30", "P=Row - 31", "P=Row - 32", "P=Row - 33", "P=Row - 34"]
        ]
        
        for expSection in expDataSource {
            baseSectionsDataSource.append(BaseExpandableSectionData(isExpanded: true, numberOfRowsInSection: expSection.count))
        }

        setExpandableArrow(frame: CGRect(x: self.view.frame.width - 30, y: 10, width:13, height: 13), tint: UIColor.blue)
        
        tableView.register(ExpandableCell.self, forCellReuseIdentifier: expandableCellId)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: expandableCellId)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: baseEexpandableCellId, for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: expandableCellId, for: indexPath)
        let name = expDataSource[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = super.tableView(tableView, viewForHeaderInSection: section)!
        hView.backgroundColor = UIColor.lightGray
        
        let headerTitle = UILabel(frame: CGRect(x: 30, y: 15, width: self.view.frame.width, height: 20))
        headerTitle.text = expDataSource[section][0]
        hView.addSubview(headerTitle)
    
        return hView
    }
}
