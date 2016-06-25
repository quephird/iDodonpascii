//
//  Enemy.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/5/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode, GameSprite, Scrubbable {
    var world: SKNode? = nil
    var spawnDelay: Double? = nil
    var direction: Direction? = nil
    var hitPoints: Int? = nil
    var points: UInt? = nil
    var animationFrames: [SKTexture] = []

    init(initParms: EnemyInitializationParameters) {
        self.world = initParms.world
        self.spawnDelay = initParms.spawnDelay
        self.direction = initParms.direction
        self.hitPoints = initParms.hitPoints

        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
        self.position = CGPoint(x: initParms.initialX, y: initParms.initialY)
        self.zPosition = 100
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func explodeAndDie() {
        self.physicsBody = nil
        let explosionFrames:[SKTexture] = [
                textureAtlas.textureNamed("explosion1.png"),
                textureAtlas.textureNamed("explosion2.png"),
                textureAtlas.textureNamed("explosion3.png"),
                textureAtlas.textureNamed("explosion4.png"),
        ],
        explosionAction = SKAction.animateWithTextures(explosionFrames, timePerFrame: 0.1),
        explodeAndDieAction = SKAction.sequence([
                explosionAction,
                SKAction.removeFromParent()
        ])
        self.runAction(explodeAndDieAction)
    }
    
    func getPlayerPosition() -> CGPoint {
        let gameScene = self.world! as! GameScene
        return gameScene.player.position
    }
    
    // TODO: Figure out how to customize bullet types and bullet patterns 
    //       per each enemy subclass.
    func startFiringBullets() {
        let randomDelay = drand48()
        let randomInitialDelayAction = SKAction.waitForDuration(randomDelay)
        let bulletCycleAction = SKAction.waitForDuration(0.75)
        let spawnNewBulletAction = SKAction.runBlock{
            let newBullet = EnemyBullet(parentNode: self)
            newBullet.spawn()
        }
        let continuousFiringAction = SKAction.sequence([spawnNewBulletAction, bulletCycleAction])
        self.runAction(SKAction.sequence([randomInitialDelayAction,
                                          SKAction.repeatActionForever(continuousFiringAction)]))
    }
}

