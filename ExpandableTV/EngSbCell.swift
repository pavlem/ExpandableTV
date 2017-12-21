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
        titleEng.text = expandableEngagementData!.title
        editBtn.isHidden = expandableEngagementData!.isEditable ? true : false
        imageEng.kf.indicatorType = .activity
        imageEng.kf.setImage(with: URL(string: expandableEngagementData!.imageUrl))

    }
}

extension EngSbCell {
    class func getMocData() -> [ExpandableEngagementSectionData] {
        let section1 = [
            ExpandableEngagementData(title: "Row - 00", description: "Row - 00 - description", status: "Row - 00 - status", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/jolie.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 01", description: "Row - 01 - description", status: "Row - 00 - status", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/tom.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 02", description: "Row - 02 - description", status: "Row - 02 - status", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/will.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 03", description: "Row - 03 - description", status: "Row - 03 - status", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/johnny.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 04", description: "Row - 04 - description", status: "Row - 04 - status", imageUrl: "https://static.pexels.com/photos/213399/pexels-photo-213399.jpeg", isEditable: true),
            ExpandableEngagementData(title: "Row - 05", description: "Row - 05 - description", status: "Row - 05 - status", imageUrl: "http://microblogging.wingnity.com/JSONParsingTutorial/brad.jpg", isEditable: true),
            ]
        
        let section2 = [
            ExpandableEngagementData(title: "Row - 10", description: "Row - 10 - description", status: "Row - 00 - status", imageUrl: "https://octopus-development.s3.eu-west-1.amazonaws.com/p/6992c532-a9f2-4478-988a-9e1002e44caa/2dff7124-89eb-4e22-8284-156bb356d4fb/oki-logo.png", isEditable: true),
            ExpandableEngagementData(title: "Row - 11", description: "Row - 11 - description", status: "Row - 10 - status", imageUrl: "https://octopus-development.s3.eu-west-1.amazonaws.com/p/6992c532-a9f2-4478-988a-9e1002e44caa/a43d0d3c-6fbe-44ba-be44-06fdfbdd47fe/cocacola_logo_28559.jpg", isEditable: true),
            ExpandableEngagementData(title: "Row - 12", description: "Row - 12 - description", status: "Row - 12 - status", imageUrl: "https://octopus-development.s3.eu-west-1.amazonaws.com/p/6992c532-a9f2-4478-988a-9e1002e44caa/2ae754f4-6371-448f-9ccd-dfad375cd8f8/Coca-Cola-logo-D5C4C21E06-seeklogo.com.png", isEditable: true),
            ExpandableEngagementData(title: "Row - 13", description: "Row - 13 - description", status: "Row - 13 - status", imageUrl: "https://octopus-development.s3.eu-west-1.amazonaws.com/p/6992c532-a9f2-4478-988a-9e1002e44caa/3b212ac8-d791-4553-9aea-36743debe412/0403160628_burito%20madre1.png", isEditable: true),
            ExpandableEngagementData(title: "Row - 14", description: "Row - 14 - description", status: "Row - 14 - status", imageUrl: "https://octopus-development.s3.eu-west-1.amazonaws.com/p/6992c532-a9f2-4478-988a-9e1002e44caa/3b212ac8-d791-4553-9aea-36743debe412/0403160628_burito%20madre1.png", isEditable: true),
            ]
        
        let expandableEngagementSectionData = [
            ExpandableEngagementSectionData(isExpanded: true, expandableData: section1, expandableSectionTitle: "Section - 0", numberOfRowsInSection: section1.count),
            ExpandableEngagementSectionData(isExpanded: true, expandableData: section2, expandableSectionTitle: "Section - 1", numberOfRowsInSection: section2.count)
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
