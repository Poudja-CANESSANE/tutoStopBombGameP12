//
//  SKLabelNode+CustomLabel.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 29/01/2021.
//

import SpriteKit

extension SKLabelNode {
    static func getCustomLabel(fontSize: CGFloat, text: String) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontName = "Super Boom"
        label.fontSize = fontSize
        label.verticalAlignmentMode = .center
        return label
    }
}
