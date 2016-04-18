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

    func fireBullet() {
        let newBullet = EnemyBullet(parentNode: self)
        newBullet.spawn()
    }
}