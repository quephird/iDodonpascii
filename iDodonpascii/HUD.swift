//
//  HUDManager.swift
//  iDodonpascii
//
//  Created by danielle kefford on 3/29/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class is responsible for:
//   * Instantiating all objects needed for the HUD
//   * Updating the HUD for each frame in the game loop.

import Foundation

class HUD {
    var scoreLabel = SKLabelNode(),
        lifeNodes = [SKSpriteNode]()

    func setup(scene: GameScene) {
        // TODO: Need HUDManager and move all this stuff there
        scoreLabel.fontName = "Courier"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = SKColor.cyanColor()
        scoreLabel.position = CGPoint(x: 0.15*scene.size.width, y: 0.95*scene.size.height)
        scoreLabel.zPosition = 100
        scene.world.addChild(scoreLabel)
        
        // TODO: Need to figure out how to track life nodes so that they can be removed when the player dies.
        for i in 0..<scene.gameState.lives! {
            let lifeNode = SKSpriteNode()
            lifeNode.size = CGSize(width: 24, height: 24)
            lifeNode.position = CGPoint(x: scene.size.width - CGFloat(i+1)*30.0, y: 0.97*scene.size.height)
            lifeNode.texture = SKTexture(imageNamed: "playerLife.png")
            lifeNode.zPosition = 100
            //            lifeNodes[i] = lifeNode
            scene.world.addChild(lifeNode)
        }
    }
    
    func update(scene: GameScene) {
        self.scoreLabel.text = String(format: "%06u", scene.gameState.score)
    }
}
