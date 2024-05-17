//
//  Sound.swift
//
//
//  Created by Ho Le Minh Thach on 22/02/2024.
//

import Foundation
import AVFoundation

class Sound: NSObject {
    /// Save list of effect sounds
    static var soundEffects = [AVAudioPlayer]()
    /// Save a single background music
    static var backgroundMusic: AVAudioPlayer? = nil

    /// This function ensure to play music in the bundle
    /// - Parameters:
    ///   - sound: the file name in the bundle
    ///   - type: type of the file
    ///   - category: the role of sound in this app
    ///   - volume: the volumn of the sound
    ///   - numberOfLoops: number of repeated time
    ///   - isBackgroundMusic: is the sound background music?
    static func play(sound: String, type: String, category: AVAudioSession.Category, volume: Float = 1,  numberOfLoops: Int = 0, isBackgroundMusic: Bool = false) {
        if let audioURL = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                /// make the audio player
                let audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                /// Number of times to loop the audio
                audioPlayer.numberOfLoops = numberOfLoops
                if isBackgroundMusic {
                    stopBGMusic()
                    backgroundMusic = audioPlayer
                    backgroundMusic?.setVolume(1, fadeDuration: 0.1)
                } else {
                    audioPlayer.volume = volume
                    soundEffects.append(audioPlayer)
                }
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()

                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(category, mode: .default)
                try audioSession.setActive(true)
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
        } else {
            print("No audio file found \(sound)")
        }
    }

    /// This function will store all the sounds effects
    static func storeSounds(sounds: [String]) {
        for sound in sounds {
            if let audioURL = Bundle.main.url(forResource: sound, withExtension: "m4a") {
                do {
                    /// make the audio player
                    let audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                    audioPlayer.setVolume(0.2, fadeDuration: 0.1)
                    soundEffects.append(audioPlayer)

                    let audioSession = AVAudioSession.sharedInstance()
                    try audioSession.setCategory(.playback)
                    try audioSession.setActive(true)
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
            } else {
                print("No audio file found \(sound)")
            }
        }
    }

    /// This function will get the sound instance based on the index provided
    static func play(index: Int) {
        if index < soundEffects.count {
            soundEffects[index].prepareToPlay()
            soundEffects[index].play()
        }
    }

    /// Stop the background music
    static func stopBGMusic() {
        backgroundMusic?.stop()
    }
    
    /// Stop all the sound effect and empty the list
    static func stopSoundEffect() {
        for sound in soundEffects {
            sound.stop()
        }
        soundEffects.removeAll()
    }

}
