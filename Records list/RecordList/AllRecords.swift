//
//  AllRecords.swift
//  Records list
//
//  Created by Александр Осипов on 09.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class AllRecords {
    
    var records: [Record]?
    var delegate: PresentDataProtocol?
    var fetcherService = DataFetcherService()
    
    func getAllRecords(session: String) {
        fetcherService.getRecords(session: session) { [weak self] (RecordResponse, Error) in
            if let error = Error {
                self?.delegate?.presentData(response: .failure(error: error.localizedDescription))
            } else if RecordResponse?.status == 0 {
                self?.delegate?.presentData(response: .failure(error: RecordResponse!.error!))
            } else {
                guard let self = self, let records = RecordResponse?.data else { return }
                self.records = records.first
                self.delegate?.presentData(response: .successAllRecords(records: RecordResponse!)!)
            }
        }
    }
}
