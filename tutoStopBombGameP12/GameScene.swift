//
//  GameScene.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 02/01/2021.
//

import SpriteKit

class GameScene: SKScene {
    // MARK: - INTERNAL

    override func didMove(to view: SKView) {
        addChild(bombNode)
        bombNode.delegate = self
        bombNode.startTimer(timeBeforeExplosion: startingTime, invisibilityTime: invisibilityTime)
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !bombNode.isStopped else { return }
        bombNode.stopTimer()
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private let bombNode = BombNode()
    private let startingTime = 1000

    private var invisibilityTime: Int {
        startingTime * 50/100
    }



    // MARK: Methods

    ///Restarts the bomb with a delay of 3 sec
    private func restart() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            bombNode.startTimer(timeBeforeExplosion: startingTime, invisibilityTime: invisibilityTime)
        }
    }
}


extension GameScene: BombNodeDelegate {
    func didExplode() {
        print("YOU LOOSE")
        restart()
    }

    func didStopBombTimerNode() {
        print("GREAT")
        restart()
    }
}
