//
//  FaceData.swift
//  
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import Foundation
import Observation

@Observable class FaceData {

    var isFaceDetected: Bool = false
    var isExhale: Bool = false
    var isChewing: Bool = false
    var isMouthOpen: Bool = false

}
