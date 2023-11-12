//
//  GenericResponseParser.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

protocol GenericResponseParser {
    
    associatedtype GenericReponseEntity
    associatedtype Json
    
    func parseData(data: Data?) -> GenericReponseEntity?
    
}
