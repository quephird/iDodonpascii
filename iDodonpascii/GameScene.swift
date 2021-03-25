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
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self

        self.backgroundManager = BackgroundManager(world: self)
        self.backgroundManager?.spawnBackgrounds()

        self.gameState.startGame()
        self.hud.setup(scene: self)
        self.player.spawn(world: self, position: CGPoint(x: 0.5*self.size.width, y: 0.1*self.size.height))
        self.spawnManager.beginSpawningEnemies(gameState: gameState, parentNode: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            player.lastTouchLocation = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self),
                dx = location.x - (player.lastTouchLocation?.x)!,
                dy = location.y - (player.lastTouchLocation?.y)!
            player.position.x += dx
            player.position.y += dy
            player.lastTouchLocation = location
            // We break here because this game does not support multitouch.
            break
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.lastTouchLocation = nil
    }

    override func update(_ currentTime: CFTimeInterval) {
        if self.gameState.lives == 0 {
            switchScene()
        }
        self.hud.update(scene: self)
        self.spawnManager.clearOffscreenEnemies()
        self.spawnManager.checkForSpawnableEnemies(elapsedTime: currentTime - self.gameState.startTime!)
    }

    func updateScore(points: UInt) {
        self.gameState.score += points
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA,
            bodyB = contact.bodyB,
            categoryMask = bodyA.categoryBitMask | bodyB.categoryBitMask

        switch categoryMask {
            case PhysicsCategory.PlayerBullet.rawValue | PhysicsCategory.Enemy.rawValue:
                if let enemy = bodyA.node as? Enemy,
                   let bullet = bodyB.node as? PlayerBullet {
                    self.handleEnemyShot(enemy: enemy, bullet: bullet)
                } else if let enemy = bodyB.node as? Enemy,
                          let bullet = bodyA.node as? PlayerBullet {
                    self.handleEnemyShot(enemy: enemy, bullet: bullet)
                }
                self.run(SKAction.playSoundFileNamed("enemyShot.wav", waitForCompletion: false))
            case PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.PlayerGraze.rawValue:
                self.run(SKAction.playSoundFileNamed("bulletGraze.wav", waitForCompletion: false))
                self.updateScore(points: 10)
            case PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.Player.rawValue:
                // TODO: Need to determine Player node and trigger explosion and reset position
                // TODO: Think about how to automatically trigger the update of the HUD when decrementing lives

                self.gameState.lives -= 1
                self.hud.removeLife()
                self.run(SKAction.playSoundFileNamed("playerShot.wav", waitForCompletion: false))
            default:
                break
        }
    }

    func handleEnemyShot(enemy: Enemy, bullet: PlayerBullet) {
        // TODO: Think about moving the hit point logic out
        enemy.hitPoints! -= 1
        bullet.removeFromParent()

        if enemy.hitPoints == 0 {
            self.updateScore(points: enemy.points!)
        }
        enemy.handleShot()
    }

    func switchScene() {
        let nextScene = EndScene(size: self.size)
        let transition = SKTransition.crossFade(withDuration: 1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
