//
//  DifficultyButtonType.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 06/01/2021.
//

import Foundation

enum DifficultyButtonType: CaseIterable {
    case easy, normal, hard

    var title: String {
        switch self {
        case .easy: return "Easy"
        case .normal: return "Normal"
        case .hard: return "Hard"
        }
    }

    var startingTimePercentage: Double {
        switch self {
        case .easy: return 0.3
        case .normal: return 0.5
        case .hard: return 0.7
        }
    }

    var nodeName: String {
        switch self {
        case .easy: return "easy"
        case .normal: return "normal"
        case .hard: return "hard"
        }
    }
}
