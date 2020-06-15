//
//  AddRecord.swift
//  Records list
//
//  Created by Александр Осипов on 09.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class AddRecord {
    
    var fetcherService = DataFetcherService()
    var delegate: PresentDataProtocol?
    var response: NewSession?
    
    func createNewRecord(session: String, userText: String) {
        
        if userText.trimmingCharacters(in: .whitespaces).isEmpty {
            let emptyTextAreaErrorMessage = "Пожалуйста, напишите что-нибудь в текстовое поле."
            self.delegate?.presentData(response: .failure(error: emptyTextAreaErrorMessage))
        } else {
            fetcherService.createNewRecord(session: session, userText: userText) { (SessionResponse, Error) in
                if let error = Error {
                    self.delegate?.presentData(response: .failure(error: error.localizedDescription))
                } else if SessionResponse?.status == 0 {
                    self.delegate?.presentData(response: .failure(error: SessionResponse!.error!))
                } else {
                    self.delegate?.presentData(response: .success)
                }
            }
        }
    }
}
