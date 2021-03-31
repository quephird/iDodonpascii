//
//  BluePlane.swift
//  iDodonpascii
//
//  Created by danielle kefford on 6/14/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class BluePlane: Enemy {
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "BluePlane"
        self.points = 100
        self.animationFrames = [
            textureAtlas.textureNamed("bluePlane1.png"),
            textureAtlas.textureNamed("bluePlane2.png")
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
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.25)
        self.run(SKAction.repeatForever(animationAction))
        
        let delayAction = SKAction.wait(forDuration: self.spawnDelay!)
        let flightPath = self.createPath()
        let flightPathAction = SKAction.follow(flightPath, duration: 3.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.run(flightActionSequence)
    }
    
    func createPath() -> CGPath {
        let path = CGMutablePath()
        // TODO: These two magic numbers also need to be scaled.
        let dx = CGFloat(self.direction == Direction.Right ? 600.0 : -600.0)
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: dx, y: -200.0))
        return path
    }
}
