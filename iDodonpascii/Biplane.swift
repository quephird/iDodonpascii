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
        self.hitPoints = 1

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
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
        let animationAction = SKAction.animate(with: self.animationFrames, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animationAction))

        let engineRunningAction = SKAction.repeatForever(SKAction.playSoundFileNamed("redPlane.wav", waitForCompletion: true))
        self.run(engineRunningAction)

        let delayAction = SKAction.wait(forDuration: self.spawnDelay!)
        let flightPath = createPath()
        let flightPathAction = SKAction.follow(flightPath, duration: 5.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.run(flightActionSequence)
    }

    func createPath() -> CGPath {
        // TODO: MOAR BAD MAGIC NUMBERZ
        var dx: CGFloat
        var startAngle: CGFloat
        var endAngle: CGFloat
        var clockwise: Bool

        if self.direction == Direction.Right {
            dx = UIScreen.main.bounds.width*1.3
            startAngle = -.π*0.5
            endAngle = .π*1.5
            clockwise = false
        } else {
            dx = -UIScreen.main.bounds.width*1.3
            startAngle = .π*1.5
            endAngle = -.π*0.5
            clockwise = true
        }
        let radius = CGFloat(100.0)

        let loopPath = CGMutablePath()
        loopPath.move(to: CGPoint(x: 0, y: 0))
        loopPath.addLine(to: CGPoint(x: 0.5*dx, y: 0))
        loopPath.addArc(center: CGPoint(x: 0.5*dx, y: radius), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        loopPath.addLine(to: CGPoint(x: dx, y: 0))

        return loopPath
    }
}
