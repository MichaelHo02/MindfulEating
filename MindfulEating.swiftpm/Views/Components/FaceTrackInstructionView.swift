//
//  FaceTrackInstructionView.swift
//
//
//  Created by Ho Le Minh Thach on 20/02/2024.
//

import SwiftUI

struct FaceTrackInstructionView: View {
    
    var model: FaceData

    @Binding var timeCount: Int

    private let instructions: [String] = [
        "Please adjust your position, we can't see your face clearly. 🫥",
        "Great! Your face is clearly visible."
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Text(instructions[model.isFaceDetected ? 1 : 0])
                    .font(.headline)

                Text("Let's continue in ^[\(timeCount) \("second")](inflect: true)! 🌟")
                    .opacity(model.isFaceDetected ? 1 : 0)
                    .animation(.easeInOut, value: model.isFaceDetected)
            }
            .padding(32)
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.gradient.opacity(0.6))
        }
        .background(.bar)
        .modifier(CardModifier())
    }
    
}

#Preview(traits: .sizeThatFitsLayout) {
    FaceTrackInstructionView(model: .init(), timeCount: .constant(1))
        .padding()
}
