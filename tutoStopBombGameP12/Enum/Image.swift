//
//  Image.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 29/01/2021.
//

import Foundation

enum Image {
    case background, bomb, pause, play, button

    var name: String {
        switch self {
        case .background: return "background"
        case .bomb: return "bomb"
        case .pause: return "pause-symbol"
        case .play: return "play-button-arrowhead"
        case .button: return "button"
        }
    }
}
