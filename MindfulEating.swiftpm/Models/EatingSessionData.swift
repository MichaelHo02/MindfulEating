//
//  EatingSessionData.swift
//
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import Foundation
import SwiftData

@Model
class EatingSessionData {

    var name: String
    var reflection: String
    var totalEatingTime: Int
    var chewPerBite: [ActivityData]
    var date: Date

    init(
        name: String = "",
        reflection: String = "",
        totalEatingTime: Int = 0,
        chewPerBite: [ActivityData] = [],
        date: Date = Date()
    ) {
        self.name = name
        self.reflection = reflection
        self.totalEatingTime = totalEatingTime
        self.chewPerBite = chewPerBite
        self.date = date
    }

    struct ActivityData: Identifiable, Codable {

        var id = UUID()
        var biteId: Int
        var chewQty: Int

        init(id: UUID = UUID(), biteId: Int = 0, chewQty: Int = 0) {
            self.id = id
            self.biteId = biteId
            self.chewQty = chewQty
        }

    }

}
