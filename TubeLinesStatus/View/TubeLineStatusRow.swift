//
//  ServiceRow.swift
//  TubeLinesStatus
//
//  Created by ANSK Vivek on 11/11/23.
//

import SwiftUI

struct TubeLineStatusRow: View {
    let line: Line
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Color(line.name.getColorName()
                )
                .frame(minWidth: 10, idealWidth: 10, maxWidth: 10, maxHeight: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8) {
                    Text(line.name)
                        .font(.custom("johnstonitcstd-bold", size: 22))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundStyle(.black)
                    Text((line.lineStatuses.first?.statusSeverityDescription)!)
                        .font(.custom("johnstonitcstd-medium", size: 22))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundStyle(.black)
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isStaticText)
                .accessibilityHint("Tap to know the updated information.")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.white)
        }
            .foregroundColor(.white)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 0)
                    .background(.clear)
                    .foregroundColor(Color.gray.opacity(0.18))
                    .padding(
                        EdgeInsets(
                            top: 3,
                            leading: 0,
                            bottom: -4,
                            trailing: 0
                        )
                    )
            )
            .listRowSeparator(.hidden)
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: -18,
                    bottom: -7,
                    trailing: -18
                )
            )
    }
}

#Preview {
    TubeLineStatusRow(line: Line(name: "Circle", lineStatuses: [LineStatus(statusSeverity: 4, statusSeverityDescription: "Good Service", reason: "")]))
}
