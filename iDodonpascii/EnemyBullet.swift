//
// Created by danielle kefford on 4/16/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class EnemyBullet: SKSpriteNode, Scrubbable, GameSprite {
    var parentNode: Enemy? = nil

    init(parentNode: Enemy) {
        super.init(texture: SKTexture(imageNamed: "heliBullet.png"), color: UIColor(), size: CGSize())
        parentNode.world!.addChild(self)
        self.parentNode = parentNode
        self.size = CGSize(width: 25, height: 25)
        self.zPosition = 100

        self.physicsBody = SKPhysicsBody(circleOfRadius: 16.0)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.EnemyBullet.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.None.rawValue
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spawn() {
        let playSoundAction = SKAction.playSoundFileNamed("enemyBullet.wav", waitForCompletion: false)

        let spinAction = SKAction.rotateByAngle(6.28, duration: 1.0)
        
        let dx = self.parentNode!.getPlayerPosition().x - self.parentNode!.position.x
        let dy = self.parentNode!.getPlayerPosition().y - self.parentNode!.position.y
        let dr = sqrt(dx*dx + dy*dy)
                // ACHTUNG! We divide dr by 400 to "normalize" in a sense; we want the bullet to travel
        //          400 pixels in any direction per second.
        let moveAction = SKAction.moveBy(CGVectorMake(dx, dy), duration: Double(dr/400.0))

        let animationAction = SKAction.runBlock {
            // Set the position of the bullet to that of the heli _after_ the delay;
            // otherwise the bullet will appear to lag behind.
            self.position = self.parentNode!.position
            self.runAction(SKAction.repeatActionForever(moveAction))
            self.runAction(SKAction.repeatActionForever(spinAction))
        }
        let entireAction = SKAction.sequence([playSoundAction, animationAction])
        self.runAction(entireAction)
    }
}
