//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by Brian Voong on 11/13/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

struct ExpandableNames {
    var isExpanded: Bool
    let names: [String]
    let headerTitle: String
}

struct Titles {
    static let open = "open"
    static let close = "close"
}

class ViewController: UITableViewController {
    
    let cellId = "cell_ID"
    
    let sectionHeaderViewHeight = CGFloat(46)
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["Row - 01", "Row - 02", "Row - 03", "Row - 04", "Row - 05", "Row - 06"], headerTitle: "Section - 0"),
        ExpandableNames(isExpanded: true, names: ["Row - 10", "Row - 11", "Row - 12", "Row - 13"], headerTitle: "Section - 1"),
        ExpandableNames(isExpanded: true, names: ["Row - 20", "Row - 21"], headerTitle: "Section - 2"),
        ExpandableNames(isExpanded: true, names: ["Row - 30", "Row - 31", "Row - 32", "Row - 33"], headerTitle: "Section - 3"),
        ExpandableNames(isExpanded: true, names: ["Row - 40", "Row - 41", "Row - 42"], headerTitle: "Section - 4")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ExpandableCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(sectionHeaderViewHeight)))
        view.backgroundColor = UIColor.orange
        
        let button = UIButton(type: .system)
        button.setTitle(Titles.close, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        button.frame = view.frame
        view.addSubview(button)
        
        let imageView = UIImageView(frame: CGRect(x: self.view.frame.width - 30, y: 10, width:13, height: 13))
        imageView.contentMode = .center
        imageView.image = self.twoDimensionalArray[section].isExpanded ? #imageLiteral(resourceName: "Down") : #imageLiteral(resourceName: "Right")
        view.addSubview(imageView)
        
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        headerTitle.text = twoDimensionalArray[section].headerTitle
        view.addSubview(headerTitle)
        view.tag = 200 + section

        return view
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let hView = tableView.viewWithTag(200 + button.tag)
        if let imageView = hView?.subviews[1] as? UIImageView {
            
            UIView.animate(withDuration: 0.2) {
                imageView.transform = imageView.transform.rotated(by: self.twoDimensionalArray[section].isExpanded ? -.pi/2 : .pi/2)
            }
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? Titles.open : Titles.close, for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderViewHeight
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExpandableCell
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
}
