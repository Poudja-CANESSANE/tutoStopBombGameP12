//
//  CountdownNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 09/01/2021.
//

import SpriteKit

class CountdownNode: SKNode {
    // MARK: - INTERNAL

    // MARK: Methods

    ///Adds resumeLabel as child then schedules timer with a TimeInterval of 1 and passes decreaseCountdown in the selector
    func startCountdown(completion: @escaping () -> Void) {
        self.completion = completion
        addChild(resumeLabel)
        
        timer = .scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(decreaseCountdown),
            userInfo: nil,
            repeats: true
        )
    }



    // MARK: - PRIVATE

    // MARK: Properties

    private lazy var resumeLabel: SKLabelNode = .getCustomLabel(fontSize: 50, text: "\(countdown)")

    private var countdown = 3 {
        didSet { resumeLabel.text = "\(countdown)" }
    }

    private var completion: () -> Void = {}
    private var timer = Timer()



    // MARK: Methods

    ///Decreases countdown of 1 till 1 is reached and calls endCountdown() if it is the case
    @objc private func decreaseCountdown() {
        if countdown == 1 { endCountdown() }
        countdown -= 1
    }

    ///Invalidates timer, removes resumeLabel and the current Countdown from their parent and calls completion
    private func endCountdown() {
        timer.invalidate()
        removeFromParent()
        completion()
    }
}
