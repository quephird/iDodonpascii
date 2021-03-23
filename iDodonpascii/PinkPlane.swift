//
//  PinkPlane.swift
//  iDodonpascii
//
//  Created by danielle kefford on 5/29/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import CoreGraphics
import SpriteKit

class PinkPlane: Enemy {
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "Biplane"
        self.points = 150
        self.animationFrames = [
            textureAtlas.textureNamed("PinkPlane1.png"),
            textureAtlas.textureNamed("PinkPlane2.png")
        ]
        self.size = CGSize(width: 100, height: 100)
        self.hitPoints = 3
        
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
        animateAndMove()
    }
    
    func animateAndMove() {
        let animationAction = SKAction.animate(with: self.animationFrames, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animationAction))
        
        let delayAction = SKAction.wait(forDuration: self.spawnDelay!)
        let flightPath = createPath()
        let flightPathAction = SKAction.follow(flightPath, duration: 7.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.run(flightActionSequence)
    }
    
    func createPath() -> CGPath {
        // TODO: MOAR BAD MAGIC NUMBERZ
        var startAngle: CGFloat
        var endAngle: CGFloat
        var clockwise: Bool
        var centerX: CGFloat
        var centerY: CGFloat
        var dx: CGFloat
        let dy: CGFloat = -300
        let radius = CGFloat(100.0)
        
        if self.direction == Direction.Right {
            centerX = radius
            centerY = dy
            startAngle = -.π
            endAngle = .π*2.0
            clockwise = false
            dx = 2.0*radius
        } else {
            centerX = -radius
            centerY = dy
            startAngle = CGFloat(0.0)
            endAngle = -.π*3.0
            clockwise = true
            dx = -2.0*radius
        }
        
        let loopPath = CGMutablePath()
        loopPath.move(to: CGPoint(x: 0, y: 0))
        loopPath.addLine(to: CGPoint(x: 0, y: dy))
        loopPath.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        loopPath.addLine(to: CGPoint(x: dx, y: 100))
        
        return loopPath
    }

    override func handleShot() {
        if self.hitPoints == 0 {
            super.handleShot()
        } else {
            let explosionFrames:[SKTexture] = [
                textureAtlas.textureNamed("pinkPlaneShot1.png"),
                textureAtlas.textureNamed("pinkPlaneShot2.png")
            ]
            let explosionAction = SKAction.animate(with: explosionFrames, timePerFrame: 0.1)
            let repeatExplosionAction = SKAction.repeatForever(explosionAction)
            self.run(repeatExplosionAction)
        }
    }
}
