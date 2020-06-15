//
//  CreateNewSession.swift
//  Records list
//
//  Created by Александр Осипов on 08.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class NewSession {
    
    var fetcherService = DataFetcherService()
    var delegate: PresentDataProtocol?
    
    func createNewSession() {
        
        fetcherService.getSession { (SessionResponse, Error) in
            if let error = Error {
                self.delegate?.presentData(response: .failure(error: error.localizedDescription))
            } else if SessionResponse?.status == 0 {
                self.delegate?.presentData(response: .failure(error: SessionResponse!.error!))
            } else {
                self.delegate?.session = SessionResponse!.data!.session
                self.delegate?.presentData(response: .success)
            }
        }
    }
}
