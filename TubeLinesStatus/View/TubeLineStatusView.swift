//
//  TubeLineStatusView.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 07/11/23.
//

import SwiftUI

struct TubeLineStatusView: View {
    
    var viewModel = TubeLineStatusViewModel()
    @State var isLoading = true

    var body: some View {
        
        List {
            ForEach(viewModel.lines, id: \.self)  { line in
                TubeLineStatusRow(line: line)
                    .redacted(reason: self.isLoading ? .placeholder : [])
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80) //minimum row height
        .padding(.leading, 10)
        .onAppear {
            viewModel.getData()
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.isLoading = false
            })
        }
    }
}

#Preview {
    TubeLineStatusView()
}
