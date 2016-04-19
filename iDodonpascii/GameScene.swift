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
    let gameState = GameState()
    let player = Player()
    let spawnManager = SpawnManager()
    let hud = HUD()

    var backgroundManager: BackgroundManager? = nil
    var playerBullets = Set<PlayerBullet>()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self

        self.backgroundManager = BackgroundManager(world: self)
        self.backgroundManager?.spawnBackgrounds()

        self.gameState.startGame()
        self.hud.setup(self)
        self.player.spawn(self, position: CGPoint(x: 0.5*self.size.width, y: 0.1*self.size.height))
        self.spawnManager.beginSpawningEnemies(gameState, parentNode: self)
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
        if self.gameState.lives == 0 {
            switchScene()
        }
        self.hud.update(self)
        self.spawnManager.clearOffscreenEnemies()
        self.spawnManager.checkForSpawnableEnemies(currentTime - self.gameState.startTime!)
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
            case PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.Player.rawValue:
                // TODO: Need to determine Player node and trigger explosion and reset position
                // TODO: Think about how to automatically trigger the update of the HUD when decrementing lives
                self.gameState.lives -= 1
                self.hud.removeLife()
                runAction(SKAction.playSoundFileNamed("playerShot.wav", waitForCompletion: false))
            default:
                break
        }
    }

    func handleEnemyShot(enemy: Enemy, bullet: PlayerBullet) {
        self.updateScore(enemy.points!)
        bullet.removeFromParent()
        enemy.explodeAndDie()
    }

    func switchScene() {
        let nextScene = EndScene(size: self.size)
        let transition = SKTransition.crossFadeWithDuration(1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
