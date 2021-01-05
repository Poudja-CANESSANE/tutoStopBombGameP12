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
            texture: SKTexture(imageNamed: ButtonState.pause.imageName),
            color: .white,
            size: CGSize(width: 100, height: 100)
        )

        position = CGPoint(
            x: presentingScene.size.width/2 - size.width + 12,
            y: presentingScene.size.height/2 - size.height + 12
        )

        zPosition = 4
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
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
        darkNode.zPosition = 3
        return darkNode
    }()

    private var state: ButtonState = .pause {
        didSet {
            texture = SKTexture(imageNamed: state.imageName)
        }
    }



    // MARK: Methods

    ///Pauses the presenting scene and darkened or not the screen according to PauseButtonNode's state
    private func togglePause() {
        if state == .pause {
            state = .play
            presentingScene.addChild(darkNode)
            presentingScene.isPaused = true
        } else {
            state = .pause
            darkNode.removeFromParent()
            presentingScene.isPaused = false
        }
    }
}
