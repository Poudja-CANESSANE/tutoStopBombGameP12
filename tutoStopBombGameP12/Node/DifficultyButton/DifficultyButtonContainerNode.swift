//
//  DifficultyButtonContainerNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 06/01/2021.
//

import SpriteKit

class DifficultyButtonContainerNode: SKSpriteNode {
    // MARK: - INTERNAL

    // MARK: Inits

    init(presentingScene: SKScene) {
        self.presentingScene = presentingScene

        super.init(
            texture: nil,
            color: .clear,
            size: CGSize(
                width: 90,
                height: DifficultyButtonType.allCases.count * singleButtonHeight +
                    (DifficultyButtonType.allCases.count - 1) * spacing
            )
        )

        position = CGPoint(
            x: (-presentingScene.size.width/2) + size.width/2 + 8,
            y: presentingScene.size.height/2 - size.height/2 - 8
        )

        addDifficultyButtonNodes()
        difficultyButtonNodes.first { $0.type == .normal }?.isSelected = true
        zPosition = ZPosition.menu.number
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: Methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchedNodeName = getTouchedNodeNameFromTouches(touches, scene: presentingScene),
              let touchedDiffficultyButton = difficultyButtonNodes.first(where: { $0.name == touchedNodeName } )
        else { return }

        deselectPreviousButton(touchedButton: touchedDiffficultyButton)
    }



    // MARK: Properties

    var difficultyButtonNodes: [DifficultyButtonNode] = []



    // MARK: - PRIVATE

    // MARK: Properties

    private let presentingScene: SKScene
    private let singleButtonHeight = 30
    private let spacing = 7



    // MARK: Methods

    ///Adds a DifficultyButtonNode of each DifficultyButtonType
    private func addDifficultyButtonNodes() {
        for (index, difficultyButtonType) in DifficultyButtonType.allCases.enumerated() {
            addSingleDifficultyButtonNode(type: difficultyButtonType, index: index)
        }
    }

    ///Adds a DifficultyButtonNode as a child
    private func addSingleDifficultyButtonNode(type: DifficultyButtonType, index: Int) {
        let difficultyButtonNode = DifficultyButtonNode(
            type: type,
            size: CGSize(width: Int(size.width), height: singleButtonHeight)
        )

        let yPosition = getYPosition(spacing: spacing, index: index)
        difficultyButtonNode.position = CGPoint(x: 0, y: yPosition)
        difficultyButtonNodes.append(difficultyButtonNode)
        addChild(difficultyButtonNode)
    }

    ///Returns the y value of the CharacterButtonItemNode's position according to the given spacing and index
    private func getYPosition(spacing: Int, index: Int) -> Double {
        let multiplier = Double(DifficultyButtonType.allCases.count) / 2.0 - 0.5
        let yShift = singleButtonHeight + spacing
        let yPosition = Double(yShift) * (Double(index) - multiplier)
        return yPosition
    }

    ///Sets all DifficultyButtonNodes' isSelected to false except for the touched one
    private func deselectPreviousButton(touchedButton: DifficultyButtonNode) {
        difficultyButtonNodes.forEach { $0.isSelected = false }
        touchedButton.isSelected = true
    }

    ///Returns the touched node's name 
    private func getTouchedNodeNameFromTouches(_ touches: Set<UITouch>, scene: SKScene) -> String? {
        guard let touchLocation = touches.first?.location(in: scene),
              let touchedNode = scene.nodes(at: touchLocation).first
        else { return nil }

        return touchedNode.name
    }
}
