//
//  GameScene.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 02/01/2021.
//

import SpriteKit

class GameScene: SKScene {
    // MARK: - INTERNAL

    // MARK: Methods

    override func didMove(to view: SKView) {
        setupDependencies()
        bombNode.startTimer(timeBeforeExplosion: startingTime, invisibilityTime: invisibilityTime)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !bombNode.isStopped, !isPaused else { return }
        bombNode.stopTimer()
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        label.text = "Starting time: \(Int(slider.value))s"
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private let bombNode = BombNode()
    private let appreciationManager = AppreciationManager()

    private var startingTime: Double { Double(Int(slider.value) * 100) }

    private var invisibilityTime: Double {
        startingTime * difficultyButtonContainerNode.selectedDifficulty.startingTimePercentage
    }

    private lazy var difficultyButtonContainerNode = DifficultyButtonContainerNode(presentingScene: self)
    private lazy var pauseButtonNode = PauseButtonNode(presentingScene: self)

    private lazy var slider: UISlider = {
        let slider = UISlider(frame: CGRect(
            origin: CGPoint(x: 28, y: view!.bounds.height * 0.92),
            size: CGSize(width: 160, height: 30)
        ))

        slider.minimumValue = 5
        slider.maximumValue = 20
        slider.value = 10
        return slider
    }()

    private lazy var label: SKLabelNode = {
        let label = SKLabelNode(text: "Starting time: \(slider.value)s")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 50
        label.horizontalAlignmentMode = .left
        label.position = CGPoint(x: -size.width/2 + 12, y: -size.height/2 * 0.77)
        label.zPosition = 3
        return label
    }()



    // MARK: Methods

    ///Adds the dependencies as children and sets their delegate if needed
    private func setupDependencies() {
        addChild(bombNode)
        addChild(appreciationManager)
        addChild(pauseButtonNode)
        addChild(difficultyButtonContainerNode)
        addChild(label)
        view?.addSubview(slider)
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
