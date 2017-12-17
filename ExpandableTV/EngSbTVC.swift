//
//  EngSbTVC.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

class EngSbTVC: ExpandableTVC {
    
    let engSBCellId = "engSBCell_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        twoDimensionalArray = [
            ExpandableNames(isExpanded: true, names: ["Row - 00", "Row - 01", "Row - 02", "Row - 03", "Row - 04", "Row - 05"], headerTitle: "Section - 0"),
            ExpandableNames(isExpanded: true, names: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"], headerTitle: "Section - 1"),
        ]
        
        navigationItem.title = "Engagements SB"
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let view = tableView.dequeueReusableCell(withIdentifier: "engSBHeaderCell_ID")!
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: 60))
        headerView.backgroundColor = UIColor.white
        
        let backgroundRect = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: 40))
        
        UIView.setCustomShadow(mainView: headerView, shadowView: backgroundRect)
        
        if self.twoDimensionalArray[section].isExpanded {
            backgroundRect.frame.size.height = 70
        }
        
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width - 30, y: 20, width:13, height: 13))
        imageView.contentMode = .center
        imageView.image = self.twoDimensionalArray[section].isExpanded ? #imageLiteral(resourceName: "Down") : #imageLiteral(resourceName: "Right")
        headerView.addSubview(imageView)
        
        if self.twoDimensionalArray[section].isExpanded {
            let viewBlocker = UIView(frame: CGRect(x: 10, y: headerView.frame.height - 20, width: self.view.frame.width - 20, height: 40))
//            UIView.setCustomShadow(mainView: headerView, shadowView: viewBlocker)
            viewBlocker.backgroundColor = .white
            headerView.addSubview(viewBlocker)
        }
        
        
        let button = UIButton(type: .system)
        button.setTitle(self.twoDimensionalArray[section].isExpanded ? Titles.close : Titles.open, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = headerView.frame
        button.backgroundColor = .clear
        headerView.addSubview(button)
        
        let headerTitle = UILabel(frame: CGRect(x: 30, y: 15, width: headerView.frame.width, height: 20))
        headerTitle.text = twoDimensionalArray[section].headerTitle
        headerView.addSubview(headerTitle)
        headerView.tag = 200 + section
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let sectionRows = twoDimensionalArray[indexPath.section]
        
        if sectionRows.names.count == indexPath.row + 1 {
            print(sectionRows.names[indexPath.row])
            return 100
        }
        
        return 60

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> EngSbCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: engSBCellId, for: indexPath) as! EngSbCell
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.titleOfEng?.text = name
        return cell
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
    
    override func toggleHeaderSection(section: Int) {
        super.toggleHeaderSection(section: section)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
