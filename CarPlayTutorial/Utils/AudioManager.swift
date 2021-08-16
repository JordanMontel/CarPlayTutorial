//
//  AudioManager.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 26/07/2021.
//

import Foundation
import AVFoundation

class AudioManager {
    
    // MARK: - Properties
    static let shared = AudioManager()
    var audioPlayer = AVPlayer()

    // MARK: - Custom Methods
    func playAudio(audioUrl: URL) {
        audioPlayer = AVPlayer(url: audioUrl)
        audioPlayer.play()
    }
    
    func pauseAudio() {
        audioPlayer.pause()
    }
}
