//
//  AudioManager.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 29/01/2021.
//

import AVFoundation

class AudioManager {
    static var audioPlayer = AVAudioPlayer()

    ///Plays the given sound name
    static func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        } catch { return }
    }
}
