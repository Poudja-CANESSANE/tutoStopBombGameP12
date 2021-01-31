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
        addBackground()
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
    private let difficultyButtonContainerNode = DifficultyButtonContainerNode()

    private var startingTime: Double { Double(Int(slider.value) * 100) }

    private var invisibilityTime: Double {
        guard let selectedDifficulty = difficultyButtonContainerNode.difficultyButtonNodes
                .first(where: { $0.isSelected }) else { return 0.0 }
        return startingTime * selectedDifficulty.type.startingTimePercentage
    }

    private lazy var pauseButtonNode = PauseButtonNode(presentingScene: self)

    private lazy var slider: UISlider = {
        let slider = UISlider(frame: CGRect(
            origin: CGPoint(x: 8, y: view!.bounds.height * 0.92),
            size: CGSize(width: 160, height: 30)
        ))

        slider.minimumValue = 5
        slider.maximumValue = 20
        slider.value = 10
        slider.tintColor = .brown
        return slider
    }()

    private lazy var label: SKLabelNode = {
        let label = SKLabelNode.getCustomLabel(fontSize: 20, text: "Starting time: \(slider.value)s")
        label.zPosition = ZPosition.menu.number
        label.horizontalAlignmentMode = .left
        label.position = CGPoint(x: -size.width/2 + 8, y: -size.height/2 * 0.77)
        return label
    }()



    // MARK: Methods

    ///Adds the background image as a child
    private func addBackground () {
        let background = SKSpriteNode(
            texture: SKTexture(imageNamed: Image.background.name),
            color: .clear,
            size: size
        )

        background.zPosition = ZPosition.background.number
        addChild(background)
    }

    ///Adds the dependencies as children and sets their delegate if needed
    private func setupDependencies() {
        addChild(bombNode)
        addChild(appreciationManager)
        addChild(pauseButtonNode)
        addChild(difficultyButtonContainerNode)
        difficultyButtonContainerNode.setup(presentingScene: self)
        addChild(label)
        view?.addSubview(slider)
        bombNode.delegate = self
    }
}


extension GameScene: BombNodeDelegate {
    func shouldRestartBomb() {
        appreciationManager.displayAppreciation(
            presentingSceneSize: size,
            startingTime: bombNode.startingTime,
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
