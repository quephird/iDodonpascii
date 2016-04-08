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
    
    func spawn(world: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 72, height: 96)) {
        world.addChild(self)
        self.size = size
        self.name = "Player"
        self.position = position

        self.setupAnimationFrames()
        self.setupPhysicsBody()
        self.startFiringBullets(world)
    }

    func setupAnimationFrames() {
        let flyFrames:[SKTexture] = [
                textureAtlas.textureNamed("player1.png"),
                textureAtlas.textureNamed("player2.png")
        ],
        flyAction = SKAction.animateWithTextures(flyFrames, timePerFrame: 0.25)
        self.runAction(SKAction.repeatActionForever(flyAction))
    }

    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player.rawValue
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }

    func startFiringBullets(world: SKNode) {
        let TIME_BETWEEN_BULLETS = 0.5,
            waitABit = SKAction.waitForDuration(TIME_BETWEEN_BULLETS),
            moveAction = SKAction.moveByX(0, y: 400, duration: 1),
            newBulletSound = SKAction.playSoundFileNamed("playerBullet.wav", waitForCompletion: false),
            spawnNewBullet = SKAction.runBlock {
                let newBullet = PlayerBullet()
                newBullet.spawn(world, position: self.makeNewBulletPosition(self.position))
                newBullet.runAction(SKAction.repeatActionForever(moveAction))
                newBullet.runAction(newBulletSound)
            },
            sequence = SKAction.sequence([waitABit, spawnNewBullet])
        self.runAction(SKAction.repeatActionForever(sequence))
    }

    func makeNewBulletPosition (playerPosition: CGPoint) -> CGPoint {
        return CGPoint(x: playerPosition.x, y: playerPosition.y+48)
    }
}
