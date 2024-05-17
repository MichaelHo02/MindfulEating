//
//  ActivityInstructionView.swift
//  
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import SwiftUI

struct ActivityInstructionView: View {

    var viewModel: ActivityViewModel

    @State private var guidingIndex: Int = 0

    var body: some View {
        let guidingInstruction = GuidingInstruction.guideInstructions[guidingIndex]
        HStack {
            VStack(alignment: .leading) {
                Text(guidingInstruction.heading)
                    .font(.headline)

                Text(guidingInstruction.subtext)
                    .lineLimit(2, reservesSpace: true)

                Text("Each time you take a new bite, we'll reveal the next helpful guide for you!")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .italic()
                    .padding(.top)
            }

            Spacer()
        }
        .padding()
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.tertiary)
        .background(.ultraThinMaterial)
        .modifier(CardModifier())
        .animation(.linear(duration: 0.1), value: guidingIndex)
        .onChange(of: viewModel.model.isMouthOpen) { oldValue, newValue in
            if newValue {
                guidingIndex = (guidingIndex + 1) % GuidingInstruction.guideInstructions.count
            }
        }
    }

}


