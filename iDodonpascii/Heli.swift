//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: SKSpriteNode, GameSprite, Enemy {
    // TODO: Move these properties into Enemy
    var world: SKNode? = nil
    var spawnDelay: Double? = nil
    var direction: Direction? = nil
    var hitPoints: Int? = nil
    var points: UInt = 100

    init(initParms: EnemyInitializationParameters) {
        self.world = initParms.world
        self.spawnDelay = initParms.spawnDelay
        self.direction = initParms.direction
        self.hitPoints = initParms.hitPoints
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
        self.name = "Heli"
        self.position = CGPoint(x: initParms.initialX, y: initParms.initialY)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: make spawn() take no arguments
    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 96)) {
        self.size = size

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue

        self.animateAndMove()
        self.world!.addChild(self)
    }

    func animateAndMove() {
        let animationFrames:[SKTexture] = [
                textureAtlas.textureNamed("heli1.png"),
                textureAtlas.textureNamed("heli2.png")
            ]
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        let flightPath = self.createPath()
        self.runAction(SKAction.repeatActionForever(animationAction))
        self.runAction(SKAction.followPath(flightPath.CGPath, duration: 3.0))
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

    // TODO: Figure out how to centralize this behavior
    func explodeAndDie() {
        // TODO: Figure out sometime why setting the contactTestBitMask to 0 is insufficient
        //       in disabling contact detection.
        self.physicsBody = nil
        let explosionFrames:[SKTexture] = [
                textureAtlas.textureNamed("explosion1.png"),
                textureAtlas.textureNamed("explosion2.png"),
                textureAtlas.textureNamed("explosion3.png"),
            ],
            explosionAction = SKAction.animateWithTextures(explosionFrames, timePerFrame: 0.1),
            explodeAndDieAction = SKAction.sequence([
                    explosionAction,
                    SKAction.removeFromParent()
            ])
        self.runAction(explodeAndDieAction)
    }
}