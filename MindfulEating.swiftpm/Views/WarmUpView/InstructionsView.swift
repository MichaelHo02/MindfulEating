//
//  InstructionsView.swift
//
//
//  Created by Ho Le Minh Thach on 15/02/2024.
//

import SwiftUI

struct InstructionsView: View {
    
    static private var title: String = "Fantastic! 🥳\nLet's get ready for\na mindful dining experience."

    static private var prompts: [String] = [
        "Ensure all distractions are closed 🤫",
        "Place the device in front of you,\nalong with your plate 🍽️",
        "Make sure the camera can capture your face 📷",
        "Let your facial expressions tell our story 📖",
        "Let's take a calming breath together before we eat, inspired by the peaceful meditation in 5 Contemplations by Buddhist monk Thich Nhat Hanh 🧘‍♂️",
        "To inhale, close your mouth and breathe in through your nose, keeping a neutral face; the balloon will expand.",
        "For exhaling, open your mouth in an 'O' shape or form a funnel; the balloon will contract.",
        "It takes time to get the exact facial expressions for both, so be patient!",
    ]
    
    @Binding var startMeditationView: Bool
    
    @State private var promptText: String       = ""
    @State private var currentPromptIndex: Int  = 0
    @State private var buttonOpacity: Double    = 0
    @State private var buttonDisable: Bool      = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 32) {
                Text(Self.title)
                    .foregroundStyle(Color.accentColor)
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 128)
                
                Text(promptText)
                    .font(.title3)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                    .lineLimit(5, reservesSpace: true)
                
                Button {
                    withAnimation(.easeOut(duration: 0.1)) {
                        currentPromptIndex += 1
                        promptText = ""
                        buttonDisable = true
                        buttonOpacity = 0
                    }
                } label: {
                    Label("Continue", systemImage: "heart.fill")
                }
                .buttonStyle(.bordered)
                .font(.system(.title, design: .monospaced))
                .controlSize(.extraLarge)
                .tint(.accentColor)
                .disabled(buttonDisable)
                .opacity(buttonOpacity)
                .animation(.easeInOut(duration: 1), value: buttonDisable)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, proxy.size.width / 8)
            .overlay(alignment: .bottom) {
                Image("WarmUpAuthor")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.height / 6)
            }
        }
        .onAppear {
            withAnimation {
                promptText = Self.prompts[currentPromptIndex]
                buttonDisable = false
                buttonOpacity = 1
            }
        }
        .onChange(of: currentPromptIndex) { _, newValue in
            if Self.prompts.count == newValue {
                startMeditationView = true
                return
            }
            withAnimation {
                promptText = Self.prompts[currentPromptIndex]
                buttonDisable = false
                buttonOpacity = 1
            }
        }
    }
    
}

#Preview {
    InstructionsView(startMeditationView: .constant(false))
}
