//
//  Line.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 12/11/23.
//

import Foundation

struct LineStatus : Codable{
    let statusSeverity : Int
    let statusSeverityDescription : String
    let reason : String?
}

struct Line : Codable, Identifiable, Hashable {
    let id : String
    let name : String
    let lineStatuses : [LineStatus]
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
