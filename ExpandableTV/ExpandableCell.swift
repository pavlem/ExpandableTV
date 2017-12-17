//
//  ExpandableCell.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/3/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit

class ExpandableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        // kind of cheat and use a hack
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "Star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(cellBtnAction), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc private func cellBtnAction() {
        print("cellBtn pressed")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
