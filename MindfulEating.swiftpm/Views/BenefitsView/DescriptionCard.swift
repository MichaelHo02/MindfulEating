//
//  DescriptionCard.swift
//  
//
//  Created by Ho Le Minh Thach on 13/02/2024.
//

import SwiftUI

struct DescriptionCard: View {
    
    var viewModel: BenefitsViewModel
    
    let benefitData: BenefitData
    let maxWidth: CGFloat
    
    var isHighlighted: Bool {
        withAnimation {
            viewModel.isHighlighted(id: benefitData.id)
        }
    }
    
    var isCompleted: Bool {
        viewModel.revealAnswers[benefitData.id]
    }
    
    var body: some View {
        HStack {
            let answer = BenefitData.benefitLabelData.filter { $0.id == benefitData.id }.first!
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.shadow(.inner(radius: 8)))
                    .foregroundStyle(Color(uiColor: .secondarySystemFill))
                    .frame(maxWidth: maxWidth, maxHeight: .infinity)
                    .scaleEffect(isHighlighted || isCompleted ? CGSize(width: 1, height: 1) : CGSize(width: 0.9, height: 0.9))
                    .overlay {
                        GeometryReader { proxy -> Color in
                            viewModel.update(frame: proxy.frame(in: .global), for: benefitData.id)
                            return Color.clear
                        }
                    }
                
                Text(answer.text)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: maxWidth, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .background(.green)
                    .modifier(CardModifier())
                    .opacity(isCompleted ? 1.0 : 0.0)
            }
            
            Image(systemName: "equal")
                .padding()
            Text(benefitData.text)
                .padding(.horizontal, 32)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(.background)
                .modifier(CardModifier())
        }
    }
    
}
