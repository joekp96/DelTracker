//
//  DeliveryDayTableViewCell.swift
//  DelTracker
//
//  Created by Joel Payne on 12/2/16.
//  Copyright © 2016 Joel Payne. All rights reserved.
//

import UIKit

class DeliveryDayTableViewCell: UITableViewCell {
	@IBOutlet var dateLabel: UILabel?
	@IBOutlet var deliveryCount: UILabel?
	@IBOutlet var totalTips: UILabel?
	@IBOutlet var totalPay: UILabel?
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
