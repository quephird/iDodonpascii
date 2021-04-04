//
//  Bfp5000Bullet.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 4/3/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class Bfp5000Bullet: SKSpriteNode, Scrubbable, GameSprite {
    init() {
        // TODO: Create new texture
        super.init(texture: SKTexture(imageNamed: "heliBullet.png"), color: UIColor(), size: CGSize())
        self.size = CGSize(width: 25, height: 25)
        self.zPosition = 100
        self.name = "EnemyBullet"

        self.physicsBody = SKPhysicsBody(circleOfRadius: 16.0)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.EnemyBullet.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player.rawValue | PhysicsCategory.PlayerGraze.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.None.rawValue
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spawn(atPosition: CGPoint, atAngle: CGFloat) {
        self.position = atPosition

        let spinAction = SKAction.rotate(byAngle: 6.28, duration: 1.0)
        self.run(SKAction.repeatForever(spinAction))

        let moveAction = SKAction.move(by: CGVector(dx: 400.0*sin(atAngle), dy: -400.0*cos(atAngle)), duration: 2.0)
        self.run(SKAction.repeatForever(moveAction))

        let playSoundAction = SKAction.playSoundFileNamed("enemyBullet.wav", waitForCompletion: false)
        self.run(playSoundAction)
    }
}
