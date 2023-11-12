//
//  TubeLineStatusViewModel.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 11/11/23.
//

import Foundation
import SwiftUI
import Observation
import Combine

@Observable
class TubeLineStatusViewModel: ObservableObject {
    var lines : [Line] = []
    let tubeStatusEndPoint = "/Line/Mode/Tube/Status"
    var cancellables = Set<AnyCancellable>()
    
    func getData() {
        NetworkManager.sharedInstance
            .getData(endPoint: tubeStatusEndPoint, parameters: ["app_key": Constants.app_key], type: Line.self)
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
            }
            .store(in: &cancellables)
    }
}
