//
//  RequestBuilder.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

protocol RequestBuilder: AnyObject {

     func createRequest(config: GenericCallConfig) -> URLRequest?
    
}
