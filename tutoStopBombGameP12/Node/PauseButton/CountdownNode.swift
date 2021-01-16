//
//  CountdownNode.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 09/01/2021.
//

import SpriteKit

class CountdownNode: SKSpriteNode {
    // MARK: - INTERNAL

    // MARK: Inits - Internal

    init(completion: @escaping () -> Void) {
        self.completion = completion
        
        super.init(
            texture: nil,
            color: .clear,
            size: CGSize(width: 200, height: 200)
        )

        zPosition = 4
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: Methods - Internal

    ///Adds resumeLabel as child then schedules timer with a TimeInterval of 1 and passes decreaseCountdown in the selector
    func startCountdown() {
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

    // MARK: Properties - Private

    private lazy var resumeLabel: SKLabelNode =  {
        let label = SKLabelNode(text: "\(countdown + 1)")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 100
        label.verticalAlignmentMode = .center
        return label
    }()

    private var countdown = 2 {
        didSet { resumeLabel.text = "\(countdown + 1)" }
    }

    private var completion: () -> Void
    private var timer = Timer()



    // MARK: Methods - Private

    ///Decreases countdown of 1 till 0 is reached and calls endCountdown() if it is the case
    @objc private func decreaseCountdown() {
        if countdown == 0 { endCountdown() }
        countdown -= 1
    }

    ///Invalidates timer, removes resumeLabel and the current Countdown from their parent,
    /// sets countdown to 3 and calls completion
    private func endCountdown() {
        timer.invalidate()
        resumeLabel.removeFromParent()
        removeFromParent()
        countdown = 3
        completion()
    }
}
