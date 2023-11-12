//
//  GenericErrorMapper.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

protocol GenericErrorMapper: AnyObject {
    
    associatedtype GenericError
    
    var createRequestError: GenericError { get }
    var parseError: GenericError { get }
    
    func map(error: NSError) -> GenericError
    func checkIfValidResponse(urlResponse: URLResponse?, data: Data?) -> GenericError?
    
}
