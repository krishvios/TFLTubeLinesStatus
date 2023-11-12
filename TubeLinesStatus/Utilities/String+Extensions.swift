//
//  String+Extensions.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation

extension String {
    func getColorName() -> String {
        self
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "&", with: "_")
            .replacingOccurrences(of: "___", with: "_")
            .replacingOccurrences(of: "__", with: "_")
            .lowercased()
    }
}
