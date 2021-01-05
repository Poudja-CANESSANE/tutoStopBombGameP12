//
//  ButtonState.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 04/01/2021.
//

import Foundation

enum ButtonState {
    case pause, play

    var imageName: String {
        switch self {
        case .pause: return "pause-symbol"
        case .play: return "play-button-arrowhead"
        }
    }
}
