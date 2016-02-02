//
//  PlayerBullet.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/4/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerBullet: SKSpriteNode, Bullet, GameSprite {
    let π = CGFloat(M_PI)

    func spawn(parentNode: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 16, height: 16)) {
        parentNode.addChild(self)
        self.size = size
        self.name = "PlayerBullet"
        self.position = position
        self.texture = SKTexture(imageNamed: "playerBullet.png")
        
        let spinAction = SKAction.rotateByAngle(2*π, duration: 1.0)
        self.runAction(SKAction.repeatActionForever(spinAction))
        
        self.physicsBody?.allowsRotation = false
    }
}
