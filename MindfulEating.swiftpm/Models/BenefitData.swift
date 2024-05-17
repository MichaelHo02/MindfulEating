//
//  BenefitData.swift
//
//
//  Created by Ho Le Minh Thach on 12/02/2024.
//

import SwiftUI

struct BenefitData: Identifiable {
    let id: Int
    let text: String
}

extension BenefitData {
    static let benefitLabelData: [BenefitData] = [
        .init(id: 0, text: "Reduced Anxiety"),
        .init(id: 1, text: "Controlled Portions"),
        .init(id: 2, text: "Improved Digestion"),
        .init(id: 3, text: "Enhanced Enjoyment"),
    ]
    
    static let benefitDescriptionData: [BenefitData] = [
        .init(id: 0, text: "Mindful eating promotes a calm and present state of mind, reducing anxiety associated with rushed or distracted eating."),
        .init(id: 1, text: "By fostering awareness of hunger and fullness cues, mindful eating helps individuals regulate portion sizes and prevent overeating."),
        .init(id: 2, text: "Eating slowly and mindfully allows for better digestion, as chewing food thoroughly aids in nutrient absorption and reduces digestive discomfort."),
        .init(id: 3, text: "By savoring each bite and appreciating the sensory experience of eating, individuals derive greater satisfaction from their meals.")
    ]
    
}
