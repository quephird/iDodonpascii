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

            case PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.PlayerGraze.rawValue:
                self.run(SKAction.playSoundFileNamed("bulletGraze.wav", waitForCompletion: false))
                self.updateScore(points: 50)

            case PhysicsCategory.EnemyBullet.rawValue | PhysicsCategory.Player.rawValue:
                // TODO: Need to determine Player node and trigger explosion and reset position
                // TODO: Think about how to automatically trigger the update of the HUD when decrementing lives

                self.gameState.lives -= 1
                self.hud.removeLife()
                self.run(SKAction.playSoundFileNamed("playerShot.wav", waitForCompletion: false))

            case PhysicsCategory.Star.rawValue | PhysicsCategory.Player.rawValue:
                if let star = bodyA.node as? Star {
                    star.removeFromParent()
                } else if let star = bodyB.node as? Star {
                    star.removeFromParent()
                }
                self.updateScore(points: 25)
                self.run(SKAction.playSoundFileNamed("starPickup.wav", waitForCompletion: false))

            case PhysicsCategory.OneThousand.rawValue | PhysicsCategory.Player.rawValue:
                if let bonus = bodyA.node as? OneThousand {
                    bonus.removeFromParent()
                } else if let bonus = bodyB.node as? OneThousand {
                    bonus.removeFromParent()
                }
                self.updateScore(points: 1000)
                self.run(SKAction.playSoundFileNamed("1000Pickup.wav", waitForCompletion: false))
            default:
                break
        }
    }

    func handleEnemyShot(enemy: Enemy, bullet: PlayerBullet) {
        self.run(SKAction.playSoundFileNamed("enemyShot.wav", waitForCompletion: false))
        bullet.removeFromParent()
        enemy.handleShot()
    }

    func switchScene() {
        let nextScene = EndScene(size: self.size)
        let transition = SKTransition.crossFade(withDuration: 1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
