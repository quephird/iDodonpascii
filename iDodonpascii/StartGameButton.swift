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
        
        let flashFrames:[SKTexture] = [
            textureAtlas.textureNamed("startGameButtonOn.png"),
            textureAtlas.textureNamed("startGameButtonOff.png")
        ],
        flashAction = SKAction.animateWithTextures(flashFrames, timePerFrame: 0.5)
        self.runAction(SKAction.repeatActionForever(flashAction))
    }
}
