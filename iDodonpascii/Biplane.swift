//
// Created by danielle kefford on 4/10/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Biplane: SKSpriteNode, GameSprite, Enemy {
    // TODO: See if this is a necessary property, should be able to create and action and run it.
    var flyAnimation = SKAction(),
        direction: Direction? = nil,
        points: UInt = 150,
        spawnDelay: Double? = nil

    // TODO: This needs to take a set of properties
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
        print("Before create animations")
        print(self.position)
        self.createAnimations()
        print("After create animations")
        print(self.position)
        self.size = size
        self.name = "Biplane"
        self.position = position
        print("After setting position")
        print(self.position)
        self.runAction(flyAnimation)

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue
    }

    func createAnimations() {
        let animationFrames:[SKTexture] = [
                textureAtlas.textureNamed("biplane1.png"),
                textureAtlas.textureNamed("biplane2.png")
        ],
        flightPath = createPath(self.position, direction: Direction.Right)
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        flyAnimation = SKAction.repeatActionForever(animationAction)
        let delayAction = SKAction.waitForDuration(self.spawnDelay!),
            flightPathAction = SKAction.followPath(flightPath.CGPath, duration: 3.0),
            flightSequence = SKAction.sequence([delayAction, flightPathAction])
        self.runAction(flightSequence)
    }

    func createPath(startingPoint: CGPoint, direction: Direction) -> UIBezierPath {
        // TODO: direction needs to be "pushed" into this object somehow and then utilized below.
        // TODO: MOAR BAD MAGIC NUMBERZ
        let path = UIBezierPath(),
            dx = CGFloat(self.direction == Direction.Right ? 600.0 : -600.0),
            endingPoint = CGPoint(x: startingPoint.x + dx, y: startingPoint.y)
        path.moveToPoint(startingPoint)
        path.addLineToPoint(endingPoint)
        print("Inside create path")
        print(path)
        return path
    }

    // TODO: Figure out how to centralize this behavior
    func explodeAndDie() {
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
