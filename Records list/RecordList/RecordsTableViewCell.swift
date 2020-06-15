//
//  RecordTableViewCell.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var daLabel: UILabel!
    @IBOutlet weak var dmLabel: UILabel!
    @IBOutlet weak var dmStackView: UIStackView!
    @IBOutlet weak var recordTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sizeToFit()
        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
