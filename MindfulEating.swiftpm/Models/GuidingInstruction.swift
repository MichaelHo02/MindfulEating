//
//  GuidingInstruction.swift
//
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import Foundation

struct GuidingInstruction {
    let heading: String
    let subtext: String
}

extension GuidingInstruction {

    static let guideInstructions: [GuidingInstruction] = [
        .init(
            heading: "What colors do you see on your plate?",
            subtext: "Pay attention to the different colors of your food; take note of the variety"
        ),
        .init(
            heading: "Can you describe the shapes of the food on your plate?",
            subtext: "Take a moment to notice and appreciate the various shapes of the items on your plate."
        ),
        .init(
            heading: "Are there any distinct smells coming from your meal?",
            subtext: "Engage your sense of smell and identify any aromas from your food."
        ),
        .init(
            heading: "Have you thought about how the food on your plate got there?",
            subtext: "Consider the journey the food took to reach your plate and the processes involved."
        ),
        .init(
            heading: "Who and what might have played a role in bringing this meal to you?",
            subtext: "Reflect on the various individuals and elements involved in the production and preparation of your food."
        ),
        .init(
            heading: "Can you sense the influence of sun and rain in your food?",
            subtext: "Consider the impact of natural elements, such as sunlight and rain, on the growth of the ingredients in your meal."
        ),
        .init(
            heading: "Does a sense of gratitude arise when you think about the conditions that brought this food to you?",
            subtext: "Reflect on the abundance of resources and circumstances that allowed your meal to be in front of you."
        ),
        .init(
            heading: "Does gratitude emerge considering the conditions that bring your food?",
            subtext: "Especially when you consider there are many people in the world today who are still hungry."
        ),
        .init(
            heading: "After taking a mouthful, intentionally pause and put your fork or spoon down.",
            subtext: "Take a moment to appreciate the act of pausing and the transition between bites."
        ),
        .init(
            heading: "When the food reaches your mouth, fully experience the taste, texture, and presence of saliva.",
            subtext: "Engage your senses in the experience of eating, paying attention to the rich sensations within your mouth."
        ),
        .init(
            heading: "What flavors do you detect in this bite?",
            subtext: "Explore the variety of tastes and textures present in the food, and be mindful of how they interact."
        ),
        .init(
            heading: "Can you sense the presence of saliva as you chew?",
            subtext: "Pay attention to the natural saliva production in your mouth, a crucial part of the digestive process."
        ),
        .init(
            heading: "Focus solely on the sensations of the present bite without immediately reaching for the next.",
            subtext: "Practice being fully present and immersed in the experience of each bite."
        ),
        .init(
            heading: "What thoughts or sensations arise when you intentionally delay picking up your spoon for the next bite?",
            subtext: "Reflect on any insights or observations that come up as you deliberately delay the next bite."
        ),
        .init(
            heading: "After you have finished eating",
            subtext: "Take a moment to reflect on where the food has \"gone.\""
        ),
    ]

}
