//
//  AppConstant.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 12/11/23.
//

import Foundation

class AppConstant: NSObject {
    static let sharedInstance = AppConstant()
    var currentAPIError : AppAPIError? = nil
}
