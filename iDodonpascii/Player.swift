//
//  Player.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/3/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite {
    var lastTouchLocation: CGPoint? = nil
    
    func spawn(world: SKScene,
               position: CGPoint,
               size: CGSize = CGSize(width: 50, height: 75)) {
        self.size = size
        self.name = "Player"
        self.position = position
        self.zPosition = 100

        self.setupAnimationFrames()
        self.setupPhysicsBody()
        self.startFiringBullets(world: world)

        let grazingNode = self.makeGrazingNode()
        world.addChild(grazingNode)
        world.addChild(self)
    }

    func setupAnimationFrames() {
        let flyFrames:[SKTexture] = [
                textureAtlas.textureNamed("player1.png"),
                textureAtlas.textureNamed("player2.png")
        ],
        flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.25)
        self.run(SKAction.repeatForever(flyAction))
    }

    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.Star.rawValue | PhysicsCategory.ExtraShot.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.None.rawValue
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }

    // We have to make a new node because we essentially cannot have one
    // radius for grazing and one for death with the same SKSpriteNode.
    func makeGrazingNode() -> SKSpriteNode {
        let grazingNode = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 0, height: 0))
        grazingNode.position = position
        grazingNode.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        grazingNode.physicsBody?.isDynamic = true
        grazingNode.physicsBody?.categoryBitMask = PhysicsCategory.PlayerGraze.rawValue
        grazingNode.physicsBody?.contactTestBitMask = PhysicsCategory.EnemyBullet.rawValue
        grazingNode.physicsBody?.collisionBitMask = PhysicsCategory.None.rawValue
        grazingNode.physicsBody?.allowsRotation = false
        grazingNode.physicsBody?.affectedByGravity = false
        let followDistance = SKRange.init(lowerLimit: 0.0, upperLimit: 0.0)
        let followConstraint = SKConstraint.distance(followDistance, to: self)
        grazingNode.constraints = [followConstraint]

        return grazingNode
    }

    func startFiringBullets(world: SKNode) {
        let bulletIndices = 1 ..< self.numberOfShots+1
        let offset: Double = Double(self.numberOfShots+1)*Double.pi/36.0
        let angles = bulletIndices.map { index in
            Double(index)*Double.pi/18.0 - offset
        }
        let actions = angles.map { angle in
            self.makeNewBulletAction(angle: angle, world: world)
        }
        let allBulletsInParallel = SKAction.group(actions)
        self.run(allBulletsInParallel)
    }

    func makeNewBulletAction(angle: Double, world: SKNode) -> SKAction {
        let TIME_BETWEEN_BULLETS = 0.5
        let waitABit = SKAction.wait(forDuration: TIME_BETWEEN_BULLETS)

        let dx = CGFloat(400.0*sin(angle))
        let dy = CGFloat(400.0*cos(angle))
        let moveAction = SKAction.moveBy(x: dx, y: dy, duration: 1)

        let newBulletSound = SKAction.playSoundFileNamed("playerBullet.wav", waitForCompletion: false)

        let spawnNewBullet = SKAction.run {
            let newBullet = PlayerBullet()
            let x = self.position.x + CGFloat(48.0*sin(angle))
            let y = self.position.y + CGFloat(48.0*cos(angle))
            let newBulletPosition = CGPoint(x: x, y: y)
            newBullet.spawn(parentNode: world, position: newBulletPosition)
            newBullet.run(SKAction.repeatForever(moveAction))
            newBullet.run(newBulletSound)
        }

        let sequence = SKAction.sequence([waitABit, spawnNewBullet])
        let newBulletAction = SKAction.repeatForever(sequence)

        return newBulletAction
    }
}
