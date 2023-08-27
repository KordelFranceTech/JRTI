//
//  Voice.swift
//  JRTI
//
//  Created by Kordel France on 8/27/23.
//

import Foundation
import MediaPlayer
import AudioToolbox


class Voice: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer = AVSpeechSynthesizer()
    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(msg: String) {
        let utterance = AVSpeechUtterance(string: msg)

        utterance.rate = Configuration.speakerRate
        utterance.pitchMultiplier = Configuration.speakerPitch
//        utterance.postUtteranceDelay = 0.2
        utterance.volume = Configuration.speakerVolume

        let voice = AVSpeechSynthesisVoice(language: "en-AU")

        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}
