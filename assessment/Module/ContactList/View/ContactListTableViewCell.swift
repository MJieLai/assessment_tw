//
//  ContactListTableViewCell.swift
//  assessment
//
//  Created by Hexa-MingJie.Lai on 16/10/2021.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageview: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        contactImageview.layer.borderWidth = 1.0
        contactImageview.layer.masksToBounds = false
        contactImageview.layer.borderColor = UIColor.white.cgColor
        contactImageview.layer.cornerRadius = 30
        contactImageview.clipsToBounds = true
        
//        contactImageview.layer.cornerRadius = contactImageview.frame.height / 2
//        contactImageview.layer.masksToBounds = true
        
        contactNameLabel.font = UIFont.systemFont(ofSize: 15)
    }
}
