//
//  addViewController.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, PresentDataProtocol {
    
    @IBOutlet weak var addTextView: UITextView!
    
    var addRecord = AddRecord()
    var session: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRecord.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBatton(_ sender: UIButton) {
        addRecord.createNewRecord(session: session!, userText: addTextView.text!)
    }
    
    func presentData(response: Load) {
        switch response {
        case .success:
            dismiss(animated: true, completion: nil)
        case .failure(let error):
            errorAlert(with: error)
        case .successAllRecords(records: _):
            break
        }
    }
    
    func errorAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)

        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}
