//
//  AppAPICall.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

class AppAPICall<M: GenericResponseParser, E: GenericErrorMapper> {

    private let responseParser: M
    private let errorMapper: E
    private let requestBuilder: RequestBuilder
    
    init(responseParser: M, errorMapper:  E, requestBuilder: RequestBuilder = AppRequestBuilder()) {
        
        self.responseParser = responseParser
        self.errorMapper = errorMapper
        self.requestBuilder = requestBuilder
    }

    @discardableResult func query(config: GenericCallConfig, success: @escaping (M.GenericReponseEntity) -> Void, failure: @escaping (E.GenericError) -> Void) -> URLSessionDataTask? {
        
        guard let request = requestBuilder.createRequest(config: config) else {
            
            self.handleFailure(error: errorMapper.createRequestError, failure: failure)
            return nil
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                if let nsError = error as? NSError {
                    let mappedError = self.errorMapper.map(error: nsError)
                    self.handleFailure(error: mappedError, failure: failure)
                }
                return
            }
            
            if let responseError = self.errorMapper.checkIfValidResponse(urlResponse: response, data: data)  {
                
                self.handleFailure(error: responseError, failure: failure)
                return
            }

            self.handleSuccess(response: response, data: data, success: success, failure: failure)
        }
        
        task.resume()
        return task
    }
    
    private func handleSuccess(response: URLResponse?, data: Data?, success: @escaping (M.GenericReponseEntity) -> Void, failure: @escaping (E.GenericError) -> Void) {
            
        if let jsonData = data  {
            
            if let entity = self.responseParser.parseData(data: jsonData) {
                
                DispatchQueue.main.async  {
                    success(entity)
                }
            }else{
                handleFailure(error: self.errorMapper.parseError, failure: failure)
            }
        }
    }
    
    private func handleFailure(error: E.GenericError, failure: @escaping (E.GenericError) -> Void) {
        
        AppConstant.sharedInstance.currentAPIError = error as? AppAPIError
        DispatchQueue.main.async  {
            print("Error = \(error)")
            failure(error)           
        }
    }
    
}


struct StaticJSONMapper  {
    
    
    
}
