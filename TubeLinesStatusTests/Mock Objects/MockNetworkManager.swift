//
//  MockNetworkManager.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 12/11/23.
//

import Foundation
import Combine

class MockNetworkManager: NetworkManager {
    
    let mockLine: Line = Line(id: "bakerloo", name: "Bakerloo", lineStatuses: [LineStatus(statusSeverity: 10, statusSeverityDescription: "Good Service", reason: "")])

    func fetchData(id: String) -> AnyPublisher<Line, Error> {
            Future { promise in
                promise(.success(self.mockLine))
            }
            .eraseToAnyPublisher()
        }
    
    func getMockData(endPoint: String? = nil, parameters: [String: String], type: Line.Type) -> Future<[Line], Error> {
        Future<[Line], Error> { promise in
            promise(.success([self.mockLine]))
        }
    }
}
