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
        self.size = CGSize(width: 32, height: 32)

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

    // TODO: Delay needs to be set by the caller, not in here;
    //       this will allow for multiple shots per Enemy.
    func spawn() {
        let randomDelay = drand48()
        let randomDelayAction = SKAction.waitForDuration(randomDelay)
        let playSoundAction = SKAction.playSoundFileNamed("enemyBullet.wav", waitForCompletion: false)

        let spinAction = SKAction.rotateByAngle(6.28, duration: 1.0)
        let x = CGFloat(self.parentNode!.direction == Direction.Right ? 50.0 : -50.0)
        let moveAction = SKAction.moveBy(CGVectorMake(x, -400.0), duration: 1)
        let animationAction = SKAction.runBlock {
            // Set the position of the bullet to that of the heli _after_ the delay;
            // otherwise the bullet will appear to lag behind.
            self.position = self.parentNode!.position
            self.runAction(SKAction.repeatActionForever(moveAction))
            self.runAction(SKAction.repeatActionForever(spinAction))
        }
        let entireAction = SKAction.sequence([randomDelayAction, playSoundAction, animationAction])
        self.runAction(entireAction)
    }
}
