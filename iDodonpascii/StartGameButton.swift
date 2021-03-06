//
//  StartGameButton.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/3/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class StartGameButton: SKSpriteNode, GameSprite {
    var lastTouchLocation: CGPoint? = nil
    
    func spawn(parentNode: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 515, height: 121)) {
        parentNode.addChild(self)
        self.size = size
        self.setScale(0.5)
        self.name = "StartGameButton"
        self.position = position
        self.zPosition = 100
        
        let flashFrames:[SKTexture] = [
            textureAtlas.textureNamed("startGameButtonOn.png"),
            textureAtlas.textureNamed("startGameButtonOff.png")
        ],
        flashAction = SKAction.animate(with: flashFrames, timePerFrame: 0.5)
        self.run(SKAction.repeatForever(flashAction))
    }
}
