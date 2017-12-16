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
            ExpandableNames(isExpanded: true, names: ["Pera - 01", "Pavle - 02", "Row - 03", "Row - 04", "Row - 05", "Row - 06"], headerTitle: "Section - 0"),
            ExpandableNames(isExpanded: true, names: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"], headerTitle: "Section - 1"),
        ]
        
        navigationItem.title = "Engagements SB"
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let view = tableView.dequeueReusableCell(withIdentifier: "engSBHeaderCell_ID")!
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(sectionHeaderViewHeight)))
        view.backgroundColor = UIColor.blue
        
        let backView = UIView(frame: CGRect(x: 10, y: 0, width: self.view.frame.width - 20, height: 60))
        backView.backgroundColor = UIColor.lightGray
        view.addSubview(backView)
        
        let button = UIButton(type: .system)
        button.setTitle(Titles.close, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = view.frame
        view.addSubview(button)
        
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width - 60, y: 10, width:13, height: 13))
        imageView.contentMode = .center
        imageView.image = self.twoDimensionalArray[section].isExpanded ? #imageLiteral(resourceName: "Down") : #imageLiteral(resourceName: "Right")
        view.addSubview(imageView)
        
        let headerTitle = UILabel(frame: CGRect(x: 30, y: 15, width: self.view.frame.width, height: 20))
        headerTitle.text = twoDimensionalArray[section].headerTitle
        view.addSubview(headerTitle)
        view.tag = 200 + section
        

        
//        let upView = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: 1))
//        upView.backgroundColor = UIColor.lightGray
//        view.addSubview(upView)
//
//        let rView = UIView(frame: CGRect(x: self.view.frame.width - 10, y: 10, width: 1, height: 50))
//        rView.backgroundColor = UIColor.lightGray
//        view.addSubview(rView)
//
//        let lView = UIView(frame: CGRect(x: 10, y: 10, width: 1, height: 50))
//        lView.backgroundColor = UIColor.lightGray
//        view.addSubview(lView)
        
        return view
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !twoDimensionalArray[section].isExpanded {
            return nil
        }
        let sectionFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10))
        sectionFooterView.backgroundColor = UIColor.orange
        return sectionFooterView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
