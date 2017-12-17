//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by Brian Voong on 11/13/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

struct ExpandableSectionData {
    var isExpanded: Bool
    let sectionTitles: [String]
    let headerTitle: String?
}

struct ExpandableHeaderTitles {
    static let open = "open"
    static let close = "close"
}

class ExpandableTVC: UITableViewController {
    
    //MARK: - API
    var sectionHeaderViewHeight = CGFloat(46)
    var sectionsDataSource = [ExpandableSectionData]()
    var isExpanderArrowShown = true
    var expandableIndicatorFrame: CGRect?
    func setHeaderTotggleBtnTitle(open: String, close: String) {
        titleOpen = open
        titleClose = close
    }

   

    //MARK: - Properties
    // Vars
    private var titleOpen: String?
    private var titleClose: String?
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
        
        tableView.register(ExpandableCell.self, forCellReuseIdentifier: expandableCellId)
    }
    
    //MARK: - Helper
    func setupExpandableArrowIndicator(onView view: UIView, forSection section: Int, indicatorFrame: CGRect, isExpanded: Bool) {
        let imageView = UIImageView(frame: indicatorFrame)
        imageView.contentMode = .center
        imageView.image = isExpanded ? #imageLiteral(resourceName: "Down") : #imageLiteral(resourceName: "Right")
        view.addSubview(imageView)
    }
    
    //MARK: - Actions
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        let isSectionexpanded = sectionsDataSource[section].isExpanded
        
        if isSectionexpanded {
            print("Closing...")
        } else {
            print("Expanding...")
        }
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in sectionsDataSource[section].sectionTitles.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let hView = tableView.viewWithTag(200 + button.tag)
        for imageView in hView!.subviews where (imageView is UIImageView) {
            UIView.animate(withDuration: 0.2) {
                imageView.transform = imageView.transform.rotated(by: self.sectionsDataSource[section].isExpanded ? -.pi/2 : .pi/2)
            }
        }
        
        sectionsDataSource[section].isExpanded = !isSectionexpanded
        
        button.setTitle(isSectionexpanded ? titleOpen : titleClose, for: .normal)
        
        if isSectionexpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
        toggleHeaderSection(section: section)
    }
    
    func toggleHeaderSection(section: Int) {
        print("toggleHeaderSection_baseExpTVC")
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(sectionHeaderViewHeight)))
        view.backgroundColor = UIColor.orange

        if isExpanderArrowShown {
            let indicatorFrame = (expandableIndicatorFrame != nil) ? expandableIndicatorFrame! : CGRect(x: self.view.frame.width - 30, y: 10, width:13, height: 13)
            setupExpandableArrowIndicator(onView: view, forSection: section, indicatorFrame: indicatorFrame, isExpanded:  self.sectionsDataSource[section].isExpanded)
        }

        let headerTitle = UILabel(frame: CGRect(x: 30, y: 15, width: self.view.frame.width, height: 20))
        headerTitle.text = sectionsDataSource[section].headerTitle
        view.addSubview(headerTitle)
        view.tag = 200 + section
        
        let button = UIButton(type: .system)
        button.setTitle(sectionsDataSource[section].isExpanded ? titleClose : titleOpen, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = view.frame
        view.addSubview(button)

        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderViewHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sectionsDataSource[section].isExpanded {
            return 0
        }
        
        return sectionsDataSource[section].sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: expandableCellId, for: indexPath) as! ExpandableCell
        let name = sectionsDataSource[indexPath.section].sectionTitles[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
