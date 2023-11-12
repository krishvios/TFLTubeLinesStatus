//
//  AppRequest.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 11/11/23.
//

import UIKit

class AppRequest {
    
    func tryToHandleError(error: AppAPIError, success: @escaping () -> Void, failure: @escaping (AppAPIError) -> Void) {
        
        failure(error)
    }
    
}
