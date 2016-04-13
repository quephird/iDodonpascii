//
// Created by danielle kefford on 4/10/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Biplane: Enemy {
    override init(initParms: EnemyInitializationParameters) {
        super.init(initParms: initParms)
        self.name = "Biplane"
        self.points = 150
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 96)) {
        self.size = size

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.3*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBullet.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue

        animateAndMove()
        self.world!.addChild(self)
    }

    func animateAndMove() {
        let animationFrames:[SKTexture] = [
                textureAtlas.textureNamed("biplane1.png"),
                textureAtlas.textureNamed("biplane2.png")
            ]
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        self.runAction(SKAction.repeatActionForever(animationAction))

        let delayAction = SKAction.waitForDuration(self.spawnDelay!)
        let flightPath = createPath()
        let flightPathAction = SKAction.followPath(flightPath.CGPath, duration: 3.0)
        let flightActionSequence = SKAction.sequence([delayAction, flightPathAction])
        self.runAction(flightActionSequence)
    }

    func createPath() -> UIBezierPath {
        // TODO: MOAR BAD MAGIC NUMBERZ
        let path = UIBezierPath()
        let dx = CGFloat(self.direction == Direction.Right ? 600.0 : -600.0)
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endingPoint = CGPoint(x: dx, y: 0.0)
        path.moveToPoint(startingPoint)
        path.addLineToPoint(endingPoint)
        return path
    }

    // TODO: Figure out how to centralize this behavior
    override func explodeAndDie() {
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
