//
//  PauseButtonNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 03/01/2021.
//

import SpriteKit

class PauseButtonNode: SKSpriteNode {
    // MARK: - INTERNAL

    // MARK: Inits

    init(presentingScene: SKScene) {
        self.presentingScene = presentingScene

        super.init(
            texture: SKTexture(imageNamed: PauseButtonState.pause.imageName),
            color: .clear,
            size: CGSize(width: 40, height: 40)
        )

        position = CGPoint(
            x: presentingScene.size.width/2 - size.width/2 - 8,
            y: presentingScene.size.height/2 - size.height/2 - 8
        )

        zPosition = ZPosition.menu.number
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard !presentingScene.children.contains(where: { $0.name == countdownNodeName }) else { return }
        togglePause()
    }


    // MARK: - PRIVATE

    // MARK: Properties

    private let presentingScene: SKScene

    private lazy var darkNode: SKSpriteNode =  {
        let darkNode = SKSpriteNode(
            color: .black,
            size: presentingScene.size
        )

        darkNode.alpha = 0.7
        return darkNode
    }()

    private var state: PauseButtonState = .pause {
        didSet { texture = SKTexture(imageNamed: state.imageName) }
    }

    private let countdownNodeName = "countdown"



    // MARK: Methods

    ///Pauses the presenting scene and darkened or not the screen according to PauseButtonNode's state
    private func togglePause() {
        state == .pause ?
            pauseGame() : resumeGame()
    }

    ///Stops the ticking sound, changes the state to .play, darkened and pauses the presenting scene
    private func pauseGame() {
        AudioManager.audioPlayer.stop()
        state = .play
        presentingScene.addChild(darkNode)
        presentingScene.isPaused = true
    }

    ///Adds a CountdownNode as the presenting scene's child then unpauses the presenting scene
    private func resumeGame() {
        alpha = 0.5
        let countdownNode = CountdownNode()
        countdownNode.name = countdownNodeName
        presentingScene.addChild(countdownNode)
        countdownNode.startCountdown(completion: playGame)
    }

    ///Unpauses the presenting scene and resume de ticking sound
    private func playGame() {
        state = .pause
        darkNode.removeFromParent()
        presentingScene.isPaused = false
        alpha = 1
        AudioManager.audioPlayer.play()
    }
}
