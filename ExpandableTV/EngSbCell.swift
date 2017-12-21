//
//  EngSbCell.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit
import Kingfisher

struct EngagementExpandableData {
    var title: String
    var description: String
    var status: String
    var imageUrl: String
    var isEditable: Bool
    
}

protocol EngagementTabCellProtocol: class {
    func editButtonTapped(indexPath: IndexPath)
}


class EngSbCell: UITableViewCell {

    //MARK: - API
    var engagementExpandableData: EngagementExpandableData? {
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
        titleEng.text = engagementExpandableData!.title
        descriptionEng.text = engagementExpandableData!.description
        statusEng.text = engagementExpandableData!.status
        titleEng.text = engagementExpandableData!.title
        editBtn.isHidden = engagementExpandableData!.isEditable ? true : false
        //Image KF download
        //Example
//        https://pbs.twimg.com/profile_images/512332086137479168/xSdFhHV9.jpeg
        
//        imageEng.kf.indicatorType = .activity
//        imageEng.kf.setImage(with: URL(string: "https://pbs.twimg.com/profile_images/512332086137479168/xSdFhHV9.jpeg"))
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
