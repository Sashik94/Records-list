//
//  ViewController.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

protocol PresentDataProtocol {
    var session: String? { get set }
    func presentData(response: Load)
}

class RecordsViewController: UIViewController, PresentDataProtocol {
    
    @IBOutlet weak var recordsTableViewCell: UITableView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var ActivityIndicatorView: UIActivityIndicatorView!
    
    var newSession = NewSession()
    var allRecords = AllRecords()
    var session: String?
    var recordList: [Record]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newSession.delegate = self
        allRecords.delegate = self
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = blurView.bounds
        blurView.addSubview(blurredEffectView)
        
        newSession.createNewSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        allRecords.getAllRecords(session: session ?? "")
    }
    
    func presentData(response: Load) {
        switch response {
        case .success:
            ActivityIndicatorView.isHidden = true
            blurView.isHidden = true
            allRecords.getAllRecords(session: session ?? "")
        case .successAllRecords(let records):
            recordList = records.data.first
            recordsTableViewCell.reloadData()
        case .failure(let error):
            errorAlert(with: error)
        }
    }
    
    func errorAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
          exit(0)
        })
        let tryAgainAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (_) in
            self?.newSession.createNewSession()
        }
        
        alertController.addAction(tryAgainAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddView" {
            let AddVC = segue.destination as! AddViewController
            AddVC.session = session
        } else if segue.identifier == "RecordView" {
            let tableViewCell = sender as! UITableViewCell
            let indexPath = recordsTableViewCell.indexPath(for: tableViewCell)!
            let RVC = segue.destination as! RecordViewController
            RVC.textRecord = recordList![indexPath.row].body
        }

    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordsTableViewCell
        if let records = recordList {
            let record = records[indexPath.row]
            
            if record.dm == "" || record.dm == record.da {
                cell.dmStackView.isHidden = true
            }
            
            cell.daLabel.text = record.da != "" ? dateFormatted(date: record.da) : ""
            cell.dmLabel.text = record.dm != "" ? dateFormatted(date: record.dm) : ""
            
            var bodyFormatted: String
            bodyFormatted = record.body
            if bodyFormatted.count > 200 {
                bodyFormatted = String(bodyFormatted.prefix(200)) + "..."
            }
            
            cell.recordTextView.text = bodyFormatted
            
        }
        return cell
    }
    
    func dateFormatted(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.timeZone = TimeZone.current
        
        let stringDate = formatter.string(from: Date(timeIntervalSince1970: Double(date)!))
        
        return stringDate
    }

}
