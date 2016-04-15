//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: Enemy {
    // TODO: size (or scale) needs to be an init parm
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "Heli"
        self.points = 100
        self.animationFrames = [
            textureAtlas.textureNamed("heli1.png"),
            textureAtlas.textureNamed("heli2.png")
        ]
        self.size = CGSize(width: 96, height: 96)

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: make spawn() take no arguments;
    func spawn() {
        self.world!.addChild(self)
        self.animateAndMove()
    }

    func animateAndMove() {
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        self.runAction(SKAction.repeatActionForever(animationAction))

        let flightPath = self.createPath()
        self.runAction(SKAction.followPath(flightPath.CGPath, duration: 3.0))

        fireBullet()
    }

    func createPath() -> UIBezierPath {
        let path = UIBezierPath()
            // The +50 is a tiny hack to ensure that the heli will go beyond the maximum y
            // such that it will be scrubbed.
        let dx = CGFloat(self.direction == Direction.Right ? 200.0 : -200.0)
        let startingPoint = CGPoint(x: 0, y: 50)
        let endingPoint = CGPoint(x: dx, y: 50)
        let controlPoint = CGPoint(x: 0.5*dx, y: -700.0)
        path.moveToPoint(startingPoint)
        path.addQuadCurveToPoint(endingPoint, controlPoint: controlPoint)
        return path
    }

    // TODO: BLECH... move this stuff to EnemyBullet.swift
    func fireBullet() {
        let newBullet = SKSpriteNode()
        self.world?.addChild(newBullet)
        newBullet.texture = SKTexture(imageNamed: "heliBullet.png")
        newBullet.size = CGSize(width: 32, height: 32)

        newBullet.physicsBody = SKPhysicsBody(circleOfRadius: 16.0)
        newBullet.physicsBody?.affectedByGravity = false
        newBullet.physicsBody?.allowsRotation = false
        newBullet.physicsBody?.categoryBitMask = PhysicsCategory.EnemyBullet.rawValue
        newBullet.physicsBody?.collisionBitMask = PhysicsCategory.None.rawValue
        newBullet.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy.rawValue

        let randomDelay = drand48()
        let randomDelayAction = SKAction.waitForDuration(randomDelay)

        let spinAction = SKAction.rotateByAngle(6.28, duration: 1.0)
        let x = CGFloat(self.direction == Direction.Right ? 50.0 : -50.0)

        let moveAction = SKAction.moveBy(CGVectorMake(x, -400.0), duration: 1)
        let playSoundAction = SKAction.playSoundFileNamed("enemyBullet.wav", waitForCompletion: false)
        let animationAction = SKAction.runBlock {
            // Set the position of the bullet to that of the heli _after_ the delay;
            // otherwise the bullet will appear to lag behind.
            newBullet.position = self.position
            newBullet.runAction(SKAction.repeatActionForever(moveAction))
            newBullet.runAction(SKAction.repeatActionForever(spinAction))
        }
        let newBulletAction = SKAction.sequence([randomDelayAction, playSoundAction, animationAction])
        self.runAction(newBulletAction)
    }

    func makeNewBulletPosition (playerPosition: CGPoint) -> CGPoint {
        return CGPoint(x: playerPosition.x, y: playerPosition.y+48)
    }
}