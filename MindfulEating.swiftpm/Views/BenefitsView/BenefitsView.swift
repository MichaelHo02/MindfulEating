//
//  BenefitsView.swift
//
//
//  Created by Ho Le Minh Thach on 11/02/2024.
//

import SwiftUI

struct BenefitsView: View {
    
    static private let title = "What are the benefits of mindful eating?"
    static private let content = "Before we dive into mindful eating, let's find out why it's helpful. Try dragging and dropping the words next to what you think they mean."
    
    @State private var viewModel = BenefitsViewModel()

    @State private var title: String    = Self.title
    @State private var content: String  = Self.content
    @State private var animationButton  = false
    
    @Binding var currentView: ContentView.DisplayView
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 32) {
                TitleAndContentView(title: $title, content: $content, contentHeight: proxy.size.width > proxy.size.height ? 64 : 94)
                    .padding(.top, proxy.size.width > proxy.size.height ? 16 : 128)
                    .padding(.horizontal, proxy.size.width / 6)
                matchingGameView(proxy: proxy)
            }
        }
    }
    
    func matchingGameView(proxy: GeometryProxy) -> some View {
        VStack(spacing: 32) {
            labelListView
                .zIndex(1)
            descriptionListView(maxWidth: proxy.size.width / 4)
                .zIndex(0)
            actionButtonListView
                .zIndex(0)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, proxy.size.width / 12)
        .background(Color(uiColor: .tertiarySystemGroupedBackground), ignoresSafeAreaEdges: .bottom)
    }
    
    var labelListView: some View {
        HStack(alignment: .center) {
            ForEach(viewModel.labelCards, id: \.id) { label in
                LabelCard(viewModel: viewModel, benefitData: label, gesture: drag)
            }
        }
    }
    
    @ViewBuilder
    func descriptionListView(maxWidth: CGFloat) -> some View {
        VStack(spacing: 16) {
            ForEach(viewModel.descriptionCards, id: \.id) { description in
                DescriptionCard(viewModel: viewModel, benefitData: description, maxWidth: maxWidth)
            }
        }
    }
    
    func drag(benefitData: BenefitData) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { state in
                viewModel.update(dragId: benefitData.id, dragPosition: state.location, dragOffset: state.translation)
            }
            .onEnded { state in
                viewModel.update(dragId: benefitData.id, dragPosition: state.location, dragOffset: state.translation)
                withAnimation {
                    viewModel.validateDropAction(dragId: benefitData.id)
                }
            }
    }
    
    var actionButtonListView: some View {
        HStack {
            Button {
                viewModel.reset()
                withAnimation {
                    viewModel.resetWithAnimation()
                }
            } label: {
                Label("Reset", systemImage: "gobackward")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            
            Button {
                withAnimation { currentView = .warmup }
            } label: {
                Label("Continue", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(viewModel.buttonDisable)
            .animation(.easeInOut, value: viewModel.buttonDisable)
        }
    }
    
}

#Preview {
    BenefitsView(currentView: .constant(.benefits))
}
