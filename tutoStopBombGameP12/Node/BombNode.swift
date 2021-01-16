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
            texture: nil,
            color: .red,
            size: CGSize(width: 200, height: 200)
        )

        addChild(timeLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: Properties

    weak var delegate: BombNodeDelegate?

    lazy var currentTime: Double = timeBeforeExplosion {
        didSet {
            let formattedTime = formatTimeAsString()
            timeLabel.text = formattedTime
        }
    }

    var isStopped = false



    // MARK: Methods

    ///Sets the BombTimerNode to the initial state then starts the timer to decrease from the given Int to 0 second with a precision of 1/100
    func startTimer(timeBeforeExplosion: Double, invisibilityTime: Double) {
        resetTimerIfNeeded()
        currentTime = timeBeforeExplosion
        self.timeBeforeExplosion = timeBeforeExplosion
        self.invisibilityTime = invisibilityTime
        runTickingAction(timeBeforeExplosion: timeBeforeExplosion, invisibilityTime: invisibilityTime)
    }

    ///Removes the SKAction associated to the timerActionKey so it stops the countdown
    func stopTimer() {
        removeAction(forKey: timerActionKey)
        isStopped = true
        color = .orange
        revealTimeLabelIfNeeded()
        delegate?.shouldRestartBomb()
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private let timerActionKey = "timer"
    private let precision: Double = 1/100

    private var timeBeforeExplosion: Double = 500
    private var invisibilityTime: Double = 300

    private lazy var timeLabel: SKLabelNode = {
        let formattedTime = formatTimeAsString()
        let label = SKLabelNode(text: formattedTime)
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 50
        label.verticalAlignmentMode = .center
        return label
    }()

    private var convertedTime: Double {
        Double(currentTime) * precision
    }



    // MARK: Methods

    ///Shows timeLabel if needed, changes the color to red if needed and sets isStopped to false
    private func resetTimerIfNeeded() {
        if color != .red { color = .red }
        isStopped = false
    }

    ///Runs the bombTickingAction and handleExplosion()
    private func runTickingAction(timeBeforeExplosion: Double, invisibilityTime: Double) {
        let tickingAction: SKAction = .repeat(
            .sequence([
                .run(decreaseCountdown),
                .wait(forDuration: precision)
            ]),
            count: Int(timeBeforeExplosion)
        )

        let timerAction: SKAction = .sequence([
            tickingAction,
            .run({
                self.handleExplosion(
                    timeBeforeExplosion: timeBeforeExplosion,
                    invisibilityTime: invisibilityTime
                )
            })
        ])

        run(timerAction, withKey: timerActionKey)
    }

    ///Decreases time of 1 till 0 is reached and calls hideLabel() if the invisibilityTime is reached
    private func decreaseCountdown() {
        if currentTime == invisibilityTime { hideTimeLabel() }
        currentTime -= 1
    }

    ///Changes the BombNode's color to blue then communicates that the bomb has exploded via the delegate pattern
    private func handleExplosion(timeBeforeExplosion: Double, invisibilityTime: Double) {
        color = .blue
        isStopped = true
        revealTimeLabelIfNeeded()
        delegate?.shouldRestartBomb()
    }

    ///Runs the fadeOut() SKAction on the label
    private func hideTimeLabel() {
        timeLabel.run(.fadeOut(withDuration: 0.3))
    }

    ///Shows timeLabel if needed
    private func revealTimeLabelIfNeeded() {
        timeLabel.run(.fadeIn(withDuration: 0.3))
    }

    ///Returns time rounded to the hundredth
    private func formatTimeAsString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        guard let formattedTime = numberFormatter.string(from: convertedTime as NSNumber)
        else { return "Error while formating time" }
        return formattedTime
    }
}
