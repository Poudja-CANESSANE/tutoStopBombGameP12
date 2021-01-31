//
//  DifficultyButtonContainerNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 06/01/2021.
//

import SpriteKit

class DifficultyButtonContainerNode: SKNode {
    // MARK: - INTERNAL

    // MARK: Methods

    ///Adds a DifficultyButtonNode of each DifficultyButtonType at the correct position and selects the normal difficulty by default
    func setup(presentingScene: SKScene) {
        self.presentingScene = presentingScene
        addDifficultyButtonNodes()
        difficultyButtonNodes.first { $0.type == .normal }?.isSelected = true
        zPosition = ZPosition.menu.number
        isUserInteractionEnabled = true
        let size = calculateAccumulatedFrame()

        position = CGPoint(
            x: -presentingScene.size.width/2 + size.width/2 + 8,
            y: presentingScene.size.height/2 - size.height/2 - 8
        )
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let presentingScene = presentingScene,
              let touchedNodeName = getTouchedNodeNameFromTouches(touches, scene: presentingScene),
              let touchedDiffficultyButton = difficultyButtonNodes.first(where: { $0.name == touchedNodeName } )
        else { return }

        deselectPreviousButton(touchedButton: touchedDiffficultyButton)
    }



    // MARK: Properties

    var difficultyButtonNodes: [DifficultyButtonNode] = []



    // MARK: - PRIVATE

    // MARK: Properties

    private var presentingScene: SKScene?
    private let singleButtonHeight = 30



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
            size: CGSize(width: 90, height: singleButtonHeight)
        )

        let yPosition = getYPosition(spacing: 7, index: index)
        difficultyButtonNode.position = CGPoint(x: 0, y: yPosition)
        difficultyButtonNodes.append(difficultyButtonNode)
        addChild(difficultyButtonNode)
    }

    ///Returns the y value of the DifficultyButtonItemNode's position according to the given spacing and index
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
