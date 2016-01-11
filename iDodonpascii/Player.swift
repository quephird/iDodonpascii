//
//  Player.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/3/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"iDodonpascii.atlas"),
        lastTouchLocation: CGPoint? = nil
    
    func spawn(parentNode: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 128)) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        // Player needs a SKPhysicsBody in order for setting dx or dy to take effect.
        self.physicsBody = SKPhysicsBody(circleOfRadius: 12)
                
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed("player1.png"),
            textureAtlas.textureNamed("player2.png")
            ],
            flyAction = SKAction.animateWithTextures(flyFrames, timePerFrame: 0.25)
        self.runAction(SKAction.repeatActionForever(flyAction))

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }
    
    func update() {
        self.physicsBody?.velocity.dy = 0
    }
}
