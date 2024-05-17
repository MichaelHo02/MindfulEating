//
//  ARTrackingViewRepresentable.swift
//  
//
//  Created by Ho Le Minh Thach on 20/02/2024.
//

import SwiftUI
import ARKit

struct ARTrackingViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = ARSCNView
    
    let sceneView: ARSCNView

    var model: FaceData

    func makeUIView(context: Context) -> ARSCNView {
        self.sceneView.session.delegate = context.coordinator
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        var parent: ARTrackingViewRepresentable
        
        init(_ parent: ARTrackingViewRepresentable) {
            self.parent = parent
            super.init()
            self.configure()
            
            // AR experiences typically involve moving the device without
            // touch input for some time, so prevent auto screen dimming.
            UIApplication.shared.isIdleTimerDisabled = true
            
            // "Reset" to run the AR session for the first time.
            self.resetTracking()
        }
        
        deinit {
            self.parent.sceneView.session.pause()
        }
        
    }
    
}

extension ARTrackingViewRepresentable.Coordinator: ARSCNViewDelegate, ARSessionDelegate {
    
    func configure() {
        self.parent.sceneView.delegate = self
        self.parent.sceneView.session.delegate = self
        self.parent.sceneView.automaticallyUpdatesLighting = true
    }
    
    /// - Tag: ARFaceTrackingSetup
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }
        configuration.isLightEstimationEnabled = true
        self.parent.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - ARSessionDelegate
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor}).first else { return }
        
        // Check if the face is currently visible
        let isFaceVisible = faceAnchor.isTracked
        if isFaceVisible {
            handleOnDetectedFace()
        } else {
            handleOnMissingFace()
        }
        
        handleOnReceivedFaceAnchor(faceAnchor)
    }
    
}

extension ARTrackingViewRepresentable.Coordinator {
    
    private func handleOnDetectedFace() {
        self.parent.model.isFaceDetected = true
    }
    
    private func handleOnMissingFace() {
        self.parent.model.isFaceDetected = false
    }
    
    private func handleOnReceivedFaceAnchor(_ faceAnchor: ARFaceAnchor) {
        if let jawOpen = faceAnchor.blendShapes[.jawOpen] as? Float,
           let mouthFunnel = faceAnchor.blendShapes[.mouthFunnel] as? Float {
            self.parent.model.isExhale = jawOpen > 0.05 || mouthFunnel > 0.05
            self.parent.model.isChewing = jawOpen > 0.05
            self.parent.model.isMouthOpen = jawOpen > 0.6
        }
    }
    
}
