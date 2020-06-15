//
//  DataFetcherService.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class DataFetcherService {
    let dataFetcher = NetworkDataFetcher()
    
    func getSession(response: @escaping (SessionResponse?, Error?) -> Void) {
        let parameters = ["a": API.newSession.rawValue]
       
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
    
    func getRecords(session: String, response: @escaping (RecordResponse?, Error?) -> Void) {
        let parameters = ["session": session,
                          "a"      : API.getEntries.rawValue]
        
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
    
    func createNewRecord(session: String, userText: String, response: @escaping (SessionResponse?, Error?) -> Void) {
        let parameters = ["session": session,
                          "body"   : userText,
                          "a"      : API.addEntry.rawValue]
        
        dataFetcher.fetchJSONData(params: parameters, response: response)
    }
}
