//
//  EngVCCell.swift
//  ExpandableTV
//
//  Created by Pavle Mijatovic on 12/15/17.
//  Copyright © 2017 Pavle Mijatovic. All rights reserved.
//

import UIKit

class EngVCCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundColor = .white
        let viewR = UIView(frame: CGRect(x: self.frame.width - 10,y: 0, width: 4, height: self.frame.height))
        viewR.backgroundColor = .gray
        let viewL = UIView(frame: CGRect(x: 10,y: 0, width: 4, height: self.frame.height))
        viewL.backgroundColor = .red

        self.addSubview(viewR)
        self.addSubview(viewL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
