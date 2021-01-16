//
//  DifficultyButtonNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 06/01/2021.
//

import SpriteKit

class DifficultyButtonNode: SKSpriteNode {
    // MARK: - INTERNAL

    // MARK: Inits

    init(type: DifficultyButtonType, size: CGSize) {
        self.type = type
        
        super.init(
            texture: nil,
            color: .blue,
            size: size
        )

        name = type.nodeName
        addLabel(title: type.title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: - PRIVATE

    // MARK: Properties

    var type: DifficultyButtonType

    var isSelected: Bool = false {
        didSet {
            color = isSelected ? .orange : .blue
        }
    }



    // MARK: Methods

    ///Adds a SKLAbelNode with the given String as child
    private func addLabel(title: String) {
        let label = SKLabelNode(text: title)
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 35
        label.verticalAlignmentMode = .center
        label.name = type.nodeName
        addChild(label)
    }
}
