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
        ZStack {
            List {
                ForEach(viewModel.lines, id: \.self)  { line in
                    TubeLineStatusRow(line: line)
                        .redacted(reason: self.isLoading ? .placeholder : [])
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 80) //minimum row height
            .padding(.leading, 10)
            .task {
                print("\(#file) \(#function) \(#line)")
                isLoading = true
                viewModel.getData()
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    isLoading = false
                })
            }
            
            if isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    TubeLineStatusView()
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.8)
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
    }
}
