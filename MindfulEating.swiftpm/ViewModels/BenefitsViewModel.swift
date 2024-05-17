//
//  BenefitsViewModel.swift
//
//
//  Created by Ho Le Minh Thach on 13/02/2024.
//

import SwiftUI

@Observable class BenefitsViewModel {

    // MARK: - Objects in the screen
    var labelCards = BenefitData.benefitLabelData.shuffled()
    var descriptionCards = BenefitData.benefitDescriptionData.shuffled()

    // MARK: - Coordinates
    @ObservationIgnored private var frames: [Int: CGRect] = [:]

    var revealAnswers: [Bool] = Array(repeating: false, count: BenefitData.benefitDescriptionData.count)

    // MARK: - Gesture Properties
    var currentSelectedLabel: Int?
    var highlightedId: Int?

    var currentSelectedOffset: CGSize = .zero

    // MARK: - Updates in the screen
    func update(frame: CGRect, for id: Int) {
        frames[id] = frame
    }

    func update(dragId: Int, dragPosition: CGPoint, dragOffset: CGSize) {
        currentSelectedLabel = dragId
        currentSelectedOffset = dragOffset

        for (id, frame) in frames where frame.contains(dragPosition) {
            if revealAnswers[id] { return }
            highlightedId = id
            return
        }

        highlightedId = nil
    }

    func isHighlighted(id: Int) -> Bool {
        highlightedId == id
    }

    var buttonDisable: Bool { revealAnswers.contains { $0 == false } }

    // MARK: Gesture Handle

    func validateDropAction(dragId: Int) {
        defer { 
            highlightedId = nil
            currentSelectedLabel = nil
        }

        guard let highlightedId else {
            resetPosition(dragId)
            return
        }

        guard highlightedId == currentSelectedLabel else {
            resetPosition(dragId)
            return
        }

        // reveal the answer
        revealAnswer(dragId)
    }

    func revealAnswer(_ id: Int) {
        revealAnswers[id] = true
    }

    func reset() {
        currentSelectedLabel = nil
        currentSelectedOffset = .zero
    }

    func resetWithAnimation() {
        labelCards.shuffle()
        descriptionCards.shuffle()
        revealAnswers = Array(repeating: false, count: BenefitData.benefitDescriptionData.count)
    }

    func resetPosition(_ dragId: Int) {
        currentSelectedOffset = .zero
    }

}
