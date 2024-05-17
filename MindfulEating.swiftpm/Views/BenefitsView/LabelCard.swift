//
//  DraggableLabelCard.swift
//  
//
//  Created by Ho Le Minh Thach on 12/02/2024.
//

import SwiftUI

struct LabelCard<Draggable: Gesture>: View {

    var viewModel: BenefitsViewModel
    
    let benefitData: BenefitData
    let gesture: (BenefitData) -> Draggable
    
    var isSelected: Bool {
        benefitData.id == viewModel.currentSelectedLabel
    }
    
    var isCompleted: Bool {
        viewModel.revealAnswers[benefitData.id]
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "checkmark")
                .scaledToFit()
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(isCompleted ? .white : .clear)
                .background(isCompleted ? .green : Color(uiColor: .secondarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            
            Text(benefitData.text)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.background)
                .modifier(CardModifier())
                .zIndex(isSelected ? 1.0 : 0)
                .offset(isSelected ? viewModel.currentSelectedOffset : .zero)
                .gesture(gesture(benefitData))
                .opacity(isCompleted ? 0.0 : 1.0)
        }
        .disabled(isCompleted || (isSelected == false && viewModel.currentSelectedLabel != nil ))
        .disabled(isCompleted)
        .zIndex(isSelected ? 1.0 : 0)
        .sensoryFeedback(.success, trigger: isCompleted)
    }

}
