//
//  ActivityViewModel.swift
//
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import SwiftUI

@Observable class ActivityViewModel {

    var model: FaceData

    init(_ model: FaceData) {
        self.model = model
    }

    var timeCount: Int  = 5
    var meditationBreathingViewTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var showMeditationBreathingView: Bool = false
    var continueButtonVisible: Bool = false

    var eatingTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var chewCounter: Int = 0
    var biteCounter: Int = 0
    var eatTimeCounter: Int = 0
    var session: EatingSessionData = .init()

    /// Handle interval update of the Display meditation breathing view timer
    func handleDisplayMeditationBreathingView(date: Date) {
        if timeCount <= 0 && showMeditationBreathingView == false {
            stopMeditationBreathingViewTimer()
            showMeditationBreathingView = true
            return
        }

        timeCount -= 1
    }

    func handleEatingTimer(date: Date) {
        eatTimeCounter += 1
    }

    func handleMouthOpen(oldValue: Bool, newValue: Bool) {
        if newValue {
            session.chewPerBite.append(
                .init(biteId: biteCounter, chewQty: chewCounter)
            )
            chewCounter = 0
            biteCounter += 1
        }
    }

    func handleIsChewing(oldValue: Bool, newValue: Bool) {
        if newValue {
            chewCounter += 1
        }
    }

    func handleFaceDetectedState(oldValue: Bool, newValue: Bool) {
        if newValue { // face detected == true
            startMeditationBreathingViewTimer()
        } else {
            timeCount = 5
            showMeditationBreathingView = false
            stopMeditationBreathingViewTimer()
        }
    }

    /// This function will start the meditationBreathingViewTimer
    func startMeditationBreathingViewTimer() {
        self.meditationBreathingViewTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    /// This function will stop the meditationBreathingViewTimer
    func stopMeditationBreathingViewTimer() {
        self.meditationBreathingViewTimer.upstream.connect().cancel()
    }

    /// This function will start the eatingTimer
    func startEatingTimer() {
        self.eatingTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    /// This function will stop the eatingTimer
    func stopEatingTimer() {
        self.eatingTimer.upstream.connect().cancel()
    }

}
