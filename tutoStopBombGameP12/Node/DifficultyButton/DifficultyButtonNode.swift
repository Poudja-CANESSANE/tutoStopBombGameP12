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
            texture: SKTexture(imageNamed: Image.button.name),
            color: .clear,
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
        didSet { alpha = isSelected ? 0.7 : 1 }
    }



    // MARK: Methods

    ///Adds a SKLAbelNode with the given String as child
    private func addLabel(title: String) {
        let label = SKLabelNode.getCustomLabel(fontSize: 15, text: title)
        label.name = type.nodeName
        label.fontColor = .white
        label.position.y = 2
        addChild(label)
    }
}
