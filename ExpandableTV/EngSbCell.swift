//
//  EngSbCell.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit
import Kingfisher

protocol EngagementTabCellProtocol: class {
    func editButtonTapped(indexPath: IndexPath)
}

class EngSbCell: UITableViewCell {

    //MARK: - API
    var expandableEngagementData: ExpandableEngagementData? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: EngagementTabCellProtocol?
    
    //MARK: - Properties
    private var cellTint: UIColor? {
        return tableView?.tintColor
    }
    //Outlets
    @IBOutlet weak var imageEng: UIImageView!
    @IBOutlet weak var titleEng: UILabel!
    @IBOutlet weak var descriptionEng: UILabel!
    @IBOutlet weak var statusEng: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backgroundRect: UIView!
    
    //MARK: - Actions
    @IBAction func editBtnAction(_ sender: UIButton) {
        if let indexPath = self.tableView?.indexPath(for: self) {
            delegate?.editButtonTapped(indexPath: indexPath)
        }
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
        self.setupCustomCellAppearance(layer: backgroundRect)
    }
    
    //MARK: - Helper
    private func setUI() {
        imageEng.layer.cornerRadius = imageEng.frame.size.width / 2
        
        let image = UIImage(named: "editEngagement")?.withRenderingMode(.alwaysTemplate)
        editBtn.setImage(image, for: .normal)
        editBtn.tintColor = cellTint
        
    }
    
    private func updateUI() {
        titleEng.text = expandableEngagementData!.title
        descriptionEng.text = expandableEngagementData!.description
        statusEng.text = expandableEngagementData!.status
        statusEng.textColor = Statuses.colors[statusEng.text!]
        titleEng.text = expandableEngagementData!.title
        editBtn.isHidden = expandableEngagementData!.isEditable ? false : true
        imageEng.kf.indicatorType = .activity
        imageEng.kf.setImage(with: URL(string: expandableEngagementData!.imageUrl))

    }
}

extension EngSbCell {
    class func getMocData() -> [ExpandableEngagementSectionData] {
        let section1 = [
            ExpandableEngagementData(title: "Row - 00", description: "Row - 00 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/jolie.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 01", description: "Row - 01 - description", status: "All", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 02", description: "Row - 02 - description", status: "Unapproved", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/will.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 03", description: "Row - 03 - description", status: "Unapproved", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/johnny.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 04", description: "Row - 04 - description", status: "Unapproved", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/cruise.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 05", description: "Row - 05 - description", status: "Unapproved", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/brad.jpg", isEditable: true)
            ]
        
        let section2 = [
            ExpandableEngagementData(title: "Row - 10", description: "Row - 10 - description", status: "All", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/jolie.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 11", description: "Row - 11 - description", status: "All", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 12", description: "Row - 12 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 13", description: "Row - 13 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 14", description: "Row - 14 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true)
            ]
        
        let section3 = [
            ExpandableEngagementData(title: "Row - 30", description: "Row - 30 - description", status: "All", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 31", description: "Row - 31 - description", status: "All", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 32", description: "Row - 32 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 33", description: "Row - 33 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 34", description: "Row - 34 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 35", description: "Row - 35 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 36", description: "Row - 36 - description", status: "Finished", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true)
            ]

        
        let expandableEngagementSectionData = [
            ExpandableEngagementSectionData(isExpanded: true, expandableData: section1, numberOfRowsInSection: section1.count, engagementType: "Promos", engagementNumber: section1.count),
            ExpandableEngagementSectionData(isExpanded: true, expandableData: section2, numberOfRowsInSection: section2.count, engagementType: "Messages", engagementNumber: section2.count),
            ExpandableEngagementSectionData(isExpanded: true, expandableData: section3, numberOfRowsInSection: section3.count, engagementType: "Coupons", engagementNumber: section3.count)
        ]
        
        return expandableEngagementSectionData
    }
}

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}

struct Statuses {
    static let colors = [
        "All" : UIColor.blue,
        "Unconfirmed" : UIColor.red,
        "Unapproved" : UIColor.red,
        "Aproved" : UIColor.red,
        "Active" : UIColor.red,
        "Rejected" : UIColor.red,
        "Disabled" : UIColor.red,
        "Deleted" : UIColor.red,
        "Finished" : UIColor.lightGray,
        "Draft" : UIColor.red,
        ]
}
