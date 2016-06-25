//
// Created by danielle kefford on 4/10/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import CoreGraphics
import SpriteKit

class Biplane: Enemy {
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "Biplane"
        self.points = 150
        self.animationFrames = [
            textureAtlas.textureNamed("biplane1.png"),
            textureAtlas.textureNamed("biplane2.png")
        ]
        self.size = CGSize(width: 75, height: 75)

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spawn() {
        self.world!.addChild(self)
        self.animateAndMove()
        self.startFiringBullets()
    }

    func animateAndMove() {
        let animationAction = SKAction.animateWithTextures(self.animationFrames, timePerFrame: 0.1)
        self.runAction(SKAction.repeatActionForever(animationAction))

        let delayAction = SKAction.waitForDuration(self.spawnDelay!)
        let flightPath = createPath()
        let flightPathAction = SKAction.followPath(flightPath, duration: 5.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.runAction(flightActionSequence)
    }

    func createPath() -> CGPath {
        // TODO: MOAR BAD MAGIC NUMBERZ
        var dx: CGFloat
        var startAngle: CGFloat
        var endAngle: CGFloat
        var clockwise: Bool

        if self.direction == Direction.Right {
            dx = CGFloat(610.0)
            startAngle = -0.5*CGFloat(M_PI)
            endAngle = 1.5*CGFloat(M_PI)
            clockwise = false
        } else {
            dx = CGFloat(-610.0)
            startAngle = 1.5*CGFloat(M_PI)
            endAngle = -0.5*CGFloat(M_PI)
            clockwise = true
        }
        let radius = CGFloat(100.0)

        let loopPath = CGPathCreateMutable()
        CGPathMoveToPoint(loopPath, nil, 0, 0)
        CGPathAddLineToPoint(loopPath, nil, 0.5*dx, 0)
        CGPathAddArc(loopPath,
                     nil,
                     0.5*dx,
                     radius,
                     radius,
                     startAngle,
                     endAngle,
                     clockwise)
        CGPathAddLineToPoint(loopPath, nil, dx, 0)

        return loopPath
    }
}
