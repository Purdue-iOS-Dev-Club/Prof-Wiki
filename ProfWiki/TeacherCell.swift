//
//  TeacherCell.swift
//  ProfWiki
//
//  Created by Youssef Elabd on 8/23/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import UIKit

class TeacherCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
