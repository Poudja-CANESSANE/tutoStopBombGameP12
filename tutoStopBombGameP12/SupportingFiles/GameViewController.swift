//
//  GameViewController.swift
//  tutoStopBombGameP12
//
//  Created by Canessane Poudja on 02/01/2021.
//

import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.size = view.bounds.size
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
    }
}
