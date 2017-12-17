//
//  BaseExpandableTVC.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/17/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import Foundation
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


class BaseExpandableTVC: UITableViewController {


}
