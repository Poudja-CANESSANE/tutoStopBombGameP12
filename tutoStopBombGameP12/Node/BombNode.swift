//
//  BombNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 02/01/2021.
//

import SpriteKit

protocol BombNodeDelegate: class {
    func shouldRestartBomb()
}

class BombNode: SKSpriteNode {
    // MARK: - INTERNAL

    // MARK: Inits

    init() {
        super.init(
            texture: SKTexture(imageNamed: Image.bomb.name),
            color: .clear,
            size: CGSize(width: 512/7, height: 648/7)
        )

        addChild(timeLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: Properties

    weak var delegate: BombNodeDelegate?

    var startingTime: Double = 1000

    lazy var currentTime: Double = 1000 {
        didSet { timeLabel.text = formatTimeAsString() }
    }

    var isStopped = false



    // MARK: Methods

    ///Sets the BombNode to the initial state then starts the timer to decrease from the given time to 0 second with a precision of 1/100
    func startTimer(timeBeforeExplosion: Double, invisibilityTime: Double) {
        texture = SKTexture(imageNamed: Image.bomb.name)
        AudioManager.playSound(named: Sound.ticking.rawValue)
        runScalingAnimation(to: self, firstScaleValue: 1.3, secondScaleValue: 1.0)
        runScalingAnimation(to: timeLabel, firstScaleValue: 1.0, secondScaleValue: 1.3)
        isStopped = false
        startingTime = timeBeforeExplosion
        currentTime = timeBeforeExplosion
        runTickingAction(timeBeforeExplosion: timeBeforeExplosion, invisibilityTime: invisibilityTime)
    }

    ///Removes the SKAction associated to the timerActionKey so it stops the countdown
    func stopTimer() {
        resetBomb()
        run(playDingSoundAction)
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private let playExplosionSoundAction: SKAction = .playSoundFileNamed(
        Sound.explosion.rawValue,
        waitForCompletion: true
    )

    private let playDingSoundAction: SKAction = .playSoundFileNamed(
        Sound.ding.rawValue,
        waitForCompletion: true
    )

    private let precision: Double = 1/100

    private lazy var timeLabel: SKLabelNode = {
        let label = SKLabelNode.getCustomLabel(fontSize: 14, text: formatTimeAsString())
        label.position = CGPoint(x: -size.width/7, y: -size.height/5)
        return label
    }()



    // MARK: Methods

    ///Starts the timer's countdown and handles the explosion when it is over
    private func runTickingAction(timeBeforeExplosion: Double, invisibilityTime: Double) {
        let tickingAction: SKAction = .repeat(
            .sequence([
                .run({ self.decreaseCountdown(invisibilityTime: invisibilityTime) }),
                .wait(forDuration: precision)
            ]),
            count: Int(timeBeforeExplosion)
        )

        let timerAction: SKAction = .sequence([tickingAction, .run(handleExplosion)])
        run(timerAction)
    }

    ///Decreases time of 1 till 0 is reached and calls hideLabel() if the invisibilityTime is reached
    private func decreaseCountdown(invisibilityTime: Double) {
        if currentTime == invisibilityTime { timeLabel.run(.fadeOut(withDuration: 0.3)) }
        currentTime -= 1
    }

    ///Resets the bomb, plays the explosion sound and animation
    private func handleExplosion() {
        resetBomb()
        run(playExplosionSoundAction)
        playExplosionAnimation()
    }

    ///Stops the ticking sound, removes all animation, sets isStopped to true,
    /// reveal the time if needed then communicates that the bomb has exploded via the delegate
    private func resetBomb() {
        AudioManager.audioPlayer.stop()
        removeAllActions()
        timeLabel.removeAllActions()
        isStopped = true
        if timeLabel.alpha < 1 { timeLabel.run(.fadeIn(withDuration: 0.1)) }
        delegate?.shouldRestartBomb()
    }

    ///Runs the explosion animation
    private func playExplosionAnimation() {
        var explosionTextures: [SKTexture] = []

        for i in 1...13 {
            let texture = SKTexture(imageNamed: "blast\(i)")
            explosionTextures.append(texture)
        }

        let explosionAction: SKAction = .animate(with: explosionTextures, timePerFrame: 0.05)

        run(explosionAction)
    }

    /// Runs a scaling animation to the given node
    private func runScalingAnimation(
        to node: SKNode,
        firstScaleValue: CGFloat,
        secondScaleValue: CGFloat
    ) {

        let scalingSequence: SKAction = .sequence([
            .scale(to: firstScaleValue, duration: 0.5),
            .scale(to: secondScaleValue, duration: 0.5)
        ])

        let scalingAnimation: SKAction = .repeatForever(scalingSequence)
        node.run(scalingAnimation)
    }

    ///Returns time rounded to the hundredth
    private func formatTimeAsString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        guard let formattedTime = numberFormatter.string(from: Double(currentTime) * precision as NSNumber)
        else { return "Error while formating time" }
        return formattedTime
    }
}
