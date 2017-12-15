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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> EngSbCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: engSBCellId, for: indexPath) as! EngSbCell
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.titleOfEng?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        super.tableView(tableView, didSelectRowAt: indexPath)
        print(indexPath)
    }
    
}
