//
//  AppRequestBuilder.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import UIKit

class AppRequestBuilder: RequestBuilder {
    
    func createRequest(config: GenericCallConfig) -> URLRequest? {
        
        guard let url = createURL(config: config) else {
            
            return nil
        }
        
        return createRequest(config: config, url: url)
    }
    
    private func createURL(config: GenericCallConfig) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "61e947967bc0550017bc61bf.mockapi.io"
        urlComponents.path = "/api/\(config.path)"
        urlComponents.queryItems = config.queryItems
        
        return urlComponents.url
    }
    
    private func createRequest(config: GenericCallConfig, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = config.requestMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let params = config.params() {
            do {
                let body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                let params = NSString(data: body , encoding: String.Encoding.utf8.rawValue)
                print("Param are ========================= \n \(String(describing: params)) \n ==================================")
                request.httpBody = body
            } catch { }
        }
        print("RequestData......:\n \(request)")
        return request
    }
    
}
