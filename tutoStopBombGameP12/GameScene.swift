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
        setupDependencies()
        bombNode.startTimer(timeBeforeExplosion: startingTime, invisibilityTime: invisibilityTime)
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !bombNode.isStopped, !isPaused else { return }
        bombNode.stopTimer()
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private let startingTime = 1000
    private let bombNode = BombNode()
    private let appreciationManager = AppreciationManager()

    private lazy var pauseButtonNode = PauseButtonNode(presentingScene: self)

    private var invisibilityTime: Int {
        startingTime * 50/100
    }



    // MARK: Methods

    ///Adds the dependencies as children and sets their delegate if needed
    private func setupDependencies() {
        addChild(bombNode)
        addChild(appreciationManager)
        addChild(pauseButtonNode)
        bombNode.delegate = self
    }
}


extension GameScene: BombNodeDelegate {
    func shouldRestartBomb() {
        appreciationManager.displayAppreciation(
            presentingSceneSize: scene?.size ?? CGSize(width: 2000, height: 2000),
            startingTime: startingTime,
            stopTime: bombNode.currentTime,
            completion: { [self] in
                bombNode.startTimer(
                    timeBeforeExplosion: startingTime,
                    invisibilityTime: invisibilityTime
                )
            }
        )
    }
}
