//
//  AppreciationManager.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 03/01/2021.
//

import SpriteKit

class AppreciationManager: SKNode {
    // MARK: - INTERNAL

    // MARK: Methods

    ///Displays an appreciation according to the stop time
    func displayAppreciation(
        presentingSceneSize: CGSize,
        startingTime: Double,
        stopTime: Double,
        completion: @escaping () -> Void = {}
    ){

        let labelNode = getLabelNode(
            presentingSceneSize: presentingSceneSize,
            startingTime: startingTime,
            stopTime: stopTime
        )

        let springAction: SKAction = .sequence([
            .scale(to: 1, duration: 0.3),
            .scale(to: 0.75, duration: 0.3),
            .wait(forDuration: 1),
            .fadeOut(withDuration: 0.3)
        ])

        let completionBlock = {
            labelNode.removeFromParent()
            completion()
        }

        addChild(labelNode)
        labelNode.run(springAction, completion: completionBlock)
    }



    // MARK: - PRIVATE

    // MARK: Methods

    ///Returns an SKLableNode whose text correspond to the correct appreciation
    private func getLabelNode(
        presentingSceneSize: CGSize,
        startingTime: Double,
        stopTime: Double
    ) -> SKLabelNode {

        let appreciation = getAppreciation(startingTime: startingTime, stopTime: stopTime)

        let labelNode = SKLabelNode.getCustomLabel(fontSize: 50, text: appreciation)
        labelNode.position = CGPoint(x: 0, y: presentingSceneSize.height/2 * 0.30)
        labelNode.setScale(0)

        return labelNode
    }

    ///Returns a String corresponding to the stop time
    private func getAppreciation(startingTime: Double, stopTime: Double) -> String {
        var appreciation = ""
        switch stopTime {
        case startingTime * 80/100...startingTime * 99/100: appreciation = "OK"
        case startingTime * 60/100...startingTime * 79/100: appreciation = "GOOD"
        case startingTime * 40/100...startingTime * 59/100: appreciation = "WELL DONE"
        case startingTime * 20/100...startingTime * 39/100: appreciation = "GREAT"
        case 1...startingTime * 19/100: appreciation = "SUPER"
        default: appreciation = "SO BAD"
        }

        return appreciation
    }
}
