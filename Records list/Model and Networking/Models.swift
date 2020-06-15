//
//  Models.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

struct SessionResponse: Decodable {
    let data: Session?
    let error: String?
    let status: Int
}

struct Session: Decodable {
    let session: String?
    let id: String?
}

struct RecordResponse: Decodable {
    let data: [[Record]]
    let error: String?
    let status: Int
}

struct Record: Decodable {
    let id: String
    let body: String
    let da: String
    let dm: String
}
