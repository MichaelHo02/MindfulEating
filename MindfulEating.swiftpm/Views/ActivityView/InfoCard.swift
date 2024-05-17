//
//  SwiftUIView.swift
//
//
//  Created by Ho Le Minh Thach on 25/02/2024.
//

import SwiftUI
import Charts

struct InfoCard: View {

    var viewModel: ActivityViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("^[\(viewModel.chewCounter) \("chew")](inflect: true)")
                        .font(.headline)

                    Text("^[\(viewModel.biteCounter) \("bite")](inflect: true)")
                        .font(.subheadline)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 80)
                .padding()

                Chart(viewModel.session.chewPerBite.suffix(3)) {
                    BarMark(
                        x: .value("Bite", $0.biteId),
                        y: .value("Chew", $0.chewQty),
                        width: .automatic
                    )
                }
                .chartXVisibleDomain(length: 3)
                .chartXScale(domain: .automatic(includesZero: false, reversed: false))
                .animation(.easeIn, value: viewModel.biteCounter)

            }

            Text("Suggested Chewing Count: 20-30 Times")
                .font(.footnote)
                .fontWeight(.semibold)
                .italic()
        }
        .padding()
        .background(.tertiary)
        .background(.ultraThinMaterial)
        .frame(maxWidth: 300)
        .modifier(CardModifier())
    }

}
