//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: SKSpriteNode, GameSprite, Scrubbable, Enemy {
    var flyAnimation = SKAction(),
        direction: Direction? = nil,
        points: UInt = 100

    init(direction: Direction) {
        self.direction = direction
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 96)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.name = "Heli"
        self.position = position
        self.runAction(flyAnimation)

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
    }

    func createAnimations() {
        let animationFrames:[SKTexture] = [
                textureAtlas.textureNamed("heli1.png"),
                textureAtlas.textureNamed("heli2.png")
            ],
            flightPath = createPath(self.position, direction: Direction.Right)
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        flyAnimation = SKAction.repeatActionForever(animationAction)
        self.runAction(SKAction.followPath(flightPath.CGPath, duration: 3.0))
    }
    
    func createPath(startingPoint: CGPoint, direction: Direction) -> UIBezierPath {
        // TODO: direction needs to be "pushed" into this object somehow and then utilized below.
        let path = UIBezierPath(),
            // The +50 is a tiny hack to ensure that the heli will go beyond the maximum y
            // such that it will be scrubbed.
            dx = CGFloat(self.direction == Direction.Right ? 200.0 : -200.0),
            endingPoint = CGPoint(x: startingPoint.x + dx, y: startingPoint.y+50),
            controlPoint = CGPoint(x: startingPoint.x + 0.5*dx, y: startingPoint.y-700.0)
        path.moveToPoint(startingPoint)
        path.addQuadCurveToPoint(endingPoint, controlPoint: controlPoint)
        return path
    }

    func explodeAndDie() {
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None.rawValue
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