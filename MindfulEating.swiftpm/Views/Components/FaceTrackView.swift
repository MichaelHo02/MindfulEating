//
//  FaceTrackView.swift
//
//
//  Created by Ho Le Minh Thach on 20/02/2024.
//

import SwiftUI
import ARKit

struct FaceTrackView: View {

    var model: FaceData
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
            ARTrackingViewRepresentable(sceneView: ARSCNView(), model: model)
        }
        .modifier(CardModifier())
    }
    
}
