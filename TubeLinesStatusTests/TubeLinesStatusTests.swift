//
//  TubeLinesStatusTests.swift
//  TubeLinesStatusTests
//
//  Created by ANSK Vivek on 07/11/23.
//

import XCTest
import Combine
@testable import TubeLinesStatus

final class TubeLinesStatusTests: XCTestCase {
    
    private var networkingService: MockNetworkManager?
    private var cancellables: Set<AnyCancellable>!
    var lines:[Line]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cancellables = []
        networkingService = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetData() throws {
        let expectation = self.expectation(description: "Fetch tube line status data")
        let tubeStatusEndPoint = "https://api.tfl.gov.uk/Line/Mode/Tube/Status"
        
        MockNetworkManager().getMockData(endPoint: tubeStatusEndPoint, parameters: ["app_key": Constants.app_key], type: Line.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.lines = response
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(self.lines?.first?.name, "Bakerloo")
        XCTAssertEqual(self.lines?.first?.lineStatuses.first?.statusSeverity, 10)
        XCTAssertEqual(self.lines?.first?.lineStatuses.first?.statusSeverityDescription, "Good Service")
    }

}

class MockNetworkManager: NetworkManager {
    
    let mockLine: Line = Line(name: "Bakerloo", lineStatuses: [LineStatus(statusSeverity: 10, statusSeverityDescription: "Good Service", reason: "")])

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
