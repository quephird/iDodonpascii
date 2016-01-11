//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "iDodonpascii.atlas")
    var flyAnimation = SKAction()

    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 128, height: 128)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.runAction(flyAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
    }

    func createAnimations() {
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed("heli1.png"),
            textureAtlas.textureNamed("heli2.png")
        ]
        let flyAction = SKAction.animateWithTextures(flyFrames, timePerFrame: 0.25)
        flyAnimation = SKAction.repeatActionForever(flyAction)
    }

    func onTap() {}
}