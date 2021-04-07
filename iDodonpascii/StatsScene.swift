//
//  StatsScene.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 4/7/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class StatsScene: SKScene {
    var gameState: GameState?

    override func didMove(to view: SKView) {
        let position = CGPoint(x: 0.5*self.size.width, y: 0.5*self.size.height)
        let background = Background(textureName: "background1.png",
                                    startingPosition: position)
        self.addChild(background)

        let shotsLabel = SKLabelNode()
        shotsLabel.fontName = "Courier"
        shotsLabel.fontSize = 36
        shotsLabel.fontColor = UIColor.cyan
        shotsLabel.position = CGPoint(x: 0.5*self.size.width, y: 0.65*self.size.height)
        shotsLabel.zPosition = 100
        shotsLabel.text = String(format: "Shots:  %6u", self.gameState?.shots as! CVarArg)
        self.addChild(shotsLabel)

        let killsLabel = SKLabelNode()
        killsLabel.fontName = "Courier"
        killsLabel.fontSize = 36
        killsLabel.fontColor = UIColor.cyan
        killsLabel.position = CGPoint(x: 0.5*self.size.width, y: 0.55*self.size.height)
        killsLabel.zPosition = 100
        killsLabel.text = String(format: "Kills:  %6u\n", self.gameState?.kills as! CVarArg)
        self.addChild(killsLabel)

        let grazesLabel = SKLabelNode()
        grazesLabel.fontName = "Courier"
        grazesLabel.fontSize = 36
        grazesLabel.fontColor = UIColor.cyan
        grazesLabel.position = CGPoint(x: 0.5*self.size.width, y: 0.45*self.size.height)
        grazesLabel.zPosition = 100
        grazesLabel.text = String(format: "Grazes: %6u\n", self.gameState?.grazes as! CVarArg)
        self.addChild(grazesLabel)

        let starsLabel = SKLabelNode()
        starsLabel.fontName = "Courier"
        starsLabel.fontSize = 36
        starsLabel.fontColor = UIColor.cyan
        starsLabel.position = CGPoint(x: 0.5*self.size.width, y: 0.35*self.size.height)
        starsLabel.zPosition = 100
        starsLabel.text = String(format: "Stars:  %6u\n", self.gameState?.stars as! CVarArg)
        self.addChild(starsLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Implement when new level is ready!!!
    }
}
