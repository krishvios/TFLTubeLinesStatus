//
//  GenericCallConfig.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

enum RequestMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
}

typealias RequestParams = [String : Any]

protocol GenericCallConfig {
    
    var requestMethod: RequestMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get set }
    
    func params() -> RequestParams?
    
}
