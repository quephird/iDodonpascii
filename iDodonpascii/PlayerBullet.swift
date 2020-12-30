//
//  PlayerBullet.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/4/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerBullet: SKSpriteNode, Scrubbable, GameSprite {
    let π = CGFloat(Double.pi)

    func spawn(parentNode: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 12, height: 12)) {
        parentNode.addChild(self)
        self.size = size
        self.name = "PlayerBullet"
        self.position = position
        self.zPosition = 100
        self.texture = SKTexture(imageNamed: "playerBullet.png")
        
        let spinAction = SKAction.rotate(byAngle: 2*π, duration: 1.0)
        self.run(SKAction.repeatForever(spinAction))

        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false

        self.physicsBody?.categoryBitMask    = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
}
