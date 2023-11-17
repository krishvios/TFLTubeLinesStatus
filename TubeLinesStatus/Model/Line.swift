//
//  Line.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 12/11/23.
//

import Foundation

struct LineStatus : Codable, Equatable {
    let statusSeverity : Int
    let statusSeverityDescription : String
    let reason : String?
}

struct Line : Codable, Hashable {
    let name : String
    let lineStatuses : [LineStatus]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
