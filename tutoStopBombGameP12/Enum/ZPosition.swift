//
//  ZPostion.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 29/01/2021.
//

import SpriteKit

enum ZPosition {
    case background, menu

    var number: CGFloat {
        switch self {
        case .background: return -1
        case .menu: return 1

        }
    }
}
