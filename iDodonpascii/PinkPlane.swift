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
        let animationAction = SKAction.animateWithTextures(self.animationFrames, timePerFrame: 0.1)
        self.runAction(SKAction.repeatActionForever(animationAction))
        
        let delayAction = SKAction.waitForDuration(self.spawnDelay!)
        let flightPath = createPath()
        let flightPathAction = SKAction.followPath(flightPath, duration: 7.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.runAction(flightActionSequence)
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
            startAngle = -1.0*CGFloat(M_PI)
            endAngle = 2.0*CGFloat(M_PI)
            clockwise = false
            dx = 2.0*radius
        } else {
            centerX = -radius
            centerY = dy
            startAngle = CGFloat(0.0)
            endAngle = -3.0*CGFloat(M_PI)
            clockwise = true
            dx = -2.0*radius
        }
        
        let loopPath = CGPathCreateMutable()
        CGPathMoveToPoint(loopPath, nil, 0, 0)
        CGPathAddLineToPoint(loopPath, nil, 0, dy)
        CGPathAddArc(loopPath,
                     nil,
                     centerX,
                     centerY,
                     radius,
                     startAngle,
                     endAngle,
                     clockwise)
        CGPathAddLineToPoint(loopPath, nil, dx, 100)
        
        return loopPath
    }
}
