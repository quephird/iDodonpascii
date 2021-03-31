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
        let TIME_BETWEEN_BULLETS = 0.5,
            waitABit = SKAction.wait(forDuration: TIME_BETWEEN_BULLETS),
            moveAction = SKAction.moveBy(x: 0, y: 400, duration: 1),
            newBulletSound = SKAction.playSoundFileNamed("playerBullet.wav", waitForCompletion: false),
            spawnNewBullet = SKAction.run {
                let newBullet = PlayerBullet()
                newBullet.spawn(parentNode: world, position: self.makeNewBulletPosition(playerPosition: self.position))
                newBullet.run(SKAction.repeatForever(moveAction))
                newBullet.run(newBulletSound)
            },
            sequence = SKAction.sequence([waitABit, spawnNewBullet])
        self.run(SKAction.repeatForever(sequence))
    }

    // TODO: Remove this; it is a silly function
    func makeNewBulletPosition (playerPosition: CGPoint) -> CGPoint {
        return CGPoint(x: playerPosition.x, y: playerPosition.y+48)
    }
}
