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
        self.name = "Bfp5000"
        self.points = 100
        self.animationFrames = [
            textureAtlas.textureNamed("bfp50001.png"),
            textureAtlas.textureNamed("bfp50002.png")
        ]
        self.size = CGSize(width: 300, height: 230)
        self.hitPoints = 50

        self.physicsBody = SKPhysicsBody(circleOfRadius: 50)
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
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animationAction))

        let engineRunning = SKAction.repeatForever(SKAction.playSoundFileNamed("bfp5000.wav", waitForCompletion: true))
        self.run(engineRunning)

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

    override func startFiringBullets() {
        let delayBetweenBullets = SKAction.wait(forDuration: 0.2)
        let leftBullet = SKAction.run{
            let newBullet = Bfp5000Bullet()
            newBullet.spawn(atPosition: self.position, atAngle: CGFloat(-Double.pi/12.0))
            self.world?.addChild(newBullet)
        }
        let centerBullet = SKAction.run{
            let newBullet = Bfp5000Bullet()
            newBullet.spawn(atPosition: self.position, atAngle: CGFloat(0.0))
            self.world?.addChild(newBullet)
        }
        let rightBullet = SKAction.run{
            let newBullet = Bfp5000Bullet()
            newBullet.spawn(atPosition: self.position, atAngle: CGFloat(Double.pi/12.0))
            self.world?.addChild(newBullet)
        }
        let bulletWave = SKAction.group([leftBullet, centerBullet, rightBullet])

        let bulletWaveWithDelay = SKAction.sequence([delayBetweenBullets, bulletWave])
        let bulletBurst = SKAction.repeat(bulletWaveWithDelay, count: 5)
        let delayBetweenBursts = SKAction.wait(forDuration: 1.0)

        let continuousFiringAction = SKAction.sequence([bulletBurst, delayBetweenBursts])
        self.run(SKAction.repeatForever(continuousFiringAction))
    }

    override func handleShot() {
        super.handleShot()
        if self.hitPoints == 0 {
            messageServer.publish(messageType: .BossDied)
        }
    }
}
