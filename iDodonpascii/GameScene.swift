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

class GameScene: SKScene {
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

        gameState.startGame()
        hud.setup(self)

        // TODO: Move these into SpawnManager?
        background.spawnBackgrounds(gameState.currentLevel!, parentNode: world)
        player.spawn(world, position: CGPoint(x: 0.5*self.size.width, y: 0.1*self.size.height))
        spawnManager.beginSpawningEnemies(gameState, parentNode: world)
        

        // TODO: Move player bullet generation elsewhere; it doesn't belong here
        let waitABit = SKAction.waitForDuration(0.25),
            moveAction = SKAction.moveByX(0, y: 400, duration: 1),
            newBulletSound = SKAction.playSoundFileNamed("playerBullet.wav", waitForCompletion: false),
            spawnNewBullet = SKAction.runBlock {
                let newBullet = PlayerBullet()
                newBullet.spawn(self.world, position: self.makeNewBulletPosition(self.player.position))
                newBullet.runAction(SKAction.repeatActionForever(moveAction))
                newBullet.runAction(newBulletSound)
//                self.playerBullets.insert(newBullet)
            },
            sequence = SKAction.sequence([waitABit, spawnNewBullet])
        self.runAction(SKAction.repeatActionForever(sequence))

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
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.lastTouchLocation = nil
    }

    override func update(currentTime: CFTimeInterval) {
        self.hud.update(self)
        self.spawnManager.clearOffscreenEnemies()
        self.spawnManager.checkForSpawnableEnemies(currentTime - self.gameState.startTime!)
        player.update()
        background.update(currentTime)
    }
    
    // TODO: Move this elsewhere; bullet generation and movement doesn't belong here
    func makeNewBulletPosition (playerPosition: CGPoint) -> CGPoint {
        return CGPoint(x: playerPosition.x, y: playerPosition.y+48)
    }
}
