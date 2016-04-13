//
//  GameScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/3/16.
//  Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class needs to:
//   * Initialize all components of the game
//   * Manage the game loop
//   * Respond to user input

class GameScene: SKScene, SKPhysicsContactDelegate {
    let world = SKNode(),
        gameState = GameState(),
        player = Player(),
        background = BackgroundManager(),
        spawnManager = SpawnManager(),
        hud = HUD()

    var playerBullets = Set<PlayerBullet>()
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.addChild(world)
        self.physicsWorld.contactDelegate = self

        self.gameState.startGame()
        self.hud.setup(self)
        self.background.spawnBackgrounds(gameState.currentLevel!, parentNode: world)
        self.player.spawn(world, position: CGPoint(x: 0.5*self.size.width, y: 0.1*self.size.height))
        self.spawnManager.beginSpawningEnemies(gameState, parentNode: world)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            player.lastTouchLocation = touch.locationInNode(self)
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self),
                dx = location.x - (player.lastTouchLocation?.x)!,
                dy = location.y - (player.lastTouchLocation?.y)!
            player.position.x += dx
            player.position.y += dy
            player.lastTouchLocation = location
            // We break here because this game does not support multitouch.
            break
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.lastTouchLocation = nil
    }

    override func update(currentTime: CFTimeInterval) {
        self.hud.update(self)
        self.spawnManager.clearOffscreenEnemies()
        self.spawnManager.checkForSpawnableEnemies(currentTime - self.gameState.startTime!)
        background.update(currentTime)
    }

    func updateScore(points: UInt) {
        self.gameState.score += points
    }

    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA,
            bodyB = contact.bodyB,
            categoryMask = bodyA.categoryBitMask | bodyB.categoryBitMask

        switch categoryMask {
            case PhysicsCategory.PlayerBullet.rawValue | PhysicsCategory.Enemy.rawValue:
                if let enemy = bodyA.node as? Enemy,
                       bullet = bodyB.node as? PlayerBullet {
                    self.handleEnemyShot(enemy, bullet: bullet)
                } else if let enemy = bodyB.node as? Enemy,
                              bullet = bodyA.node as? PlayerBullet {
                    self.handleEnemyShot(enemy, bullet: bullet)
                }

                runAction(SKAction.playSoundFileNamed("enemyShot.wav", waitForCompletion: false))
            default:
                break
        }
    }

    func handleEnemyShot(enemy: Enemy, bullet: PlayerBullet) {
        self.updateScore(enemy.points!)
        bullet.removeFromParent()
        enemy.explodeAndDie()
    }
}
