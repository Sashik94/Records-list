//
//  RecordViewController.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var textRecordTextView: UITextView!
    
    var textRecord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textRecordTextView.text = textRecord
    }

}
