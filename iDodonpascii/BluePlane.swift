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
    }
    
    func animateAndMove() {
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        self.runAction(SKAction.repeatActionForever(animationAction))
        
        let delayAction = SKAction.waitForDuration(self.spawnDelay!)
        let flightPath = self.createPath()
        let flightPathAction = SKAction.followPath(flightPath, duration: 3.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.runAction(flightActionSequence)
        
        // TODO: Figure out why bullets aren't firing.
        fireBullet()
    }
    
    func createPath() -> CGPath {
        let path = CGPathCreateMutable()
        // TODO: These two magic numbers also need to be scaled.
        let dx = CGFloat(self.direction == Direction.Right ? 600.0 : -600.0)
        CGPathMoveToPoint(path, nil, 0.0, 0.0)
        CGPathAddLineToPoint(path, nil, dx, -200.0)
        return path
    }
    
    func fireBullet() {
        let newBullet = EnemyBullet(parentNode: self)
        newBullet.spawn()
    }
}