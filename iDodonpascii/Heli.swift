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
            textureAtlas.textureNamed("heli2.png"),
            textureAtlas.textureNamed("heli3.png"),
            textureAtlas.textureNamed("heli4.png"),
            textureAtlas.textureNamed("heli5.png"),
            textureAtlas.textureNamed("heli6.png")
        ]
        self.size = CGSize(width: 100, height: 100)
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

    // TODO: Figure out how to move this into base class
    func spawn() {
        self.world!.addChild(self)
        self.animateAndMove()
        self.startFiringBullets()
    }

    func animateAndMove() {
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animationAction))

        let engineRunningAction = SKAction.repeatForever(SKAction.playSoundFileNamed("blueHeli.wav", waitForCompletion: true))
        self.run(engineRunningAction)

        let flightPath = self.createPath()
        self.run(SKAction.follow(flightPath.cgPath, duration: 3.0))
    }

    func createPath() -> UIBezierPath {
        let path = UIBezierPath()
        let dx = CGFloat(self.direction == Direction.Right ? 200.0 : -200.0)
        
        // TODO: Improve method of determining:
        //         * computing starting point to avoid being scrubbed before ever
        //              entering the field of play.
        //         * computing ending point to insure scrubbing after _leaving_
        //              the field of play.
        let startingPoint = CGPoint(x: 0, y: 40)
        let endingPoint = CGPoint(x: dx, y: 60)
        let controlPoint = CGPoint(x: 0.5*dx, y: -700.0)
        path.move(to: startingPoint)
        path.addQuadCurve(to: endingPoint, controlPoint: controlPoint)
        return path
    }
}
