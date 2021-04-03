//
//  Bfp5000.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 4/1/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import SpriteKit

class Bfp5000: Enemy {
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "BluePlane"
        self.points = 100
        self.animationFrames = [
            textureAtlas.textureNamed("bfp50001.png"),
            textureAtlas.textureNamed("bfp50002.png")
        ]
        self.size = CGSize(width: 300, height: 230)
        self.hitPoints = 50

        let bodySize = CGSize(width: 250, height: 100)
        let bodyCenter = CGPoint(x: 150, y: 100)
        self.physicsBody = SKPhysicsBody(rectangleOf: bodySize, center: bodyCenter)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue

        let alwaysUpConstraint = SKConstraint.zRotation(SKRange(constantValue: 0))
        self.constraints = [alwaysUpConstraint]
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spawn(_ parentNode: SKNode) {
        parentNode.addChild(self)
        self.animateAndMove()
        self.startFiringBullets()
    }

    func animateAndMove() {
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.25)
        self.run(SKAction.repeatForever(animationAction))

        let delayAction = SKAction.wait(forDuration: self.spawnDelay!)

        // These next two blocks of code create a path that slowly
        // moves down and then repeatedly thereafter in a circle.
        //
        //            |
        //            v
        //            |
        //          __|__
        //    _<-‾‾‾     ‾‾‾-<_
        //   /                 \
        //   \_               _/
        //     ‾‾->-_____->-‾‾
        //

        let comeDownPath = CGMutablePath()
        comeDownPath.move(to: CGPoint(x: 0, y: 0))
        let dy = 0.6*UIScreen.main.bounds.width
        comeDownPath.addLine(to: CGPoint(x: 0, y: -dy))
        let comeDownAction = SKAction.follow(comeDownPath, duration: 3.0)

        let loopPath = CGMutablePath()
        let radius = CGFloat(50.0)
        let loopCenter = CGPoint(x: 0, y: -radius)
        let startAngle = CGFloat(0.5*Double.pi)
        let endAngle = CGFloat(2.5*Double.pi)
        loopPath.addArc(center: loopCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        let loopAction = SKAction.repeatForever(SKAction.follow(loopPath, duration: 7.0))

        let flightPathAction = SKAction.sequence([comeDownAction, loopAction])
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.run(flightActionSequence)
    }
}
