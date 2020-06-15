//
//  API.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

enum API: String {
    case scheme = "https"
    case host = "bnet.i-partner.ru"
    case path = "/testAPI/"
    case newSession = "new_session"
    case getEntries = "get_entries"
    case addEntry = "add_entry"
    case token = "NjKdEJf-pM-T2IwudO"
}

enum Response<T> {
    case success(T)
    case failure(String)
}

enum Load {
    case success
    case successAllRecords(records: RecordResponse)
    case failure(error: String)
}
