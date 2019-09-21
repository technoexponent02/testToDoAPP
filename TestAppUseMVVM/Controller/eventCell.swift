//
//  eventCell.swift
//  TestAppUseMVVM
//
//  Created by Technoexponent on 20/09/19.
//  Copyright © 2019 Technoexponent. All rights reserved.
//

import UIKit

class eventCell: UITableViewCell {

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var mobileNoLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
