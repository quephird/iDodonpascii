//
//  GameScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/3/16.
//  Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let world = SKNode(),
        player = Player(),
        background = BackgroundManager()
        // TODO: Ditch SpriteKit Encounters; procedurally generate
        // enemies instead.
//        encounterManager = EncounterManager()
    
    var playerBullets = Set<PlayerBullet>()
//        startTime: CFTimeInterval? = nil
//        currentLevel: Int,
//        waveTimes: [Double],
//        nextWaveTime: Double?
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.addChild(world)
        
        background.spawn(world, position: CGPointZero)
        player.spawn(world, position: CGPoint(x: 0.5*self.size.width, y: 0.1*self.size.height))
//        Heli().spawn(world, position: CGPoint(x: 0.5*self.size.width, y: 0.5*self.size.height))

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

//        self.startTime = CACurrentMediaTime()
//        self.currentLevel = 1
//        self.waveTimes = [Double](levels[self.currentLevel!]!["waves"]!.keys)
//        self.nextWaveTime = waveTimes!.minElement()
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
        player.update()
        background.update(currentTime)

//        let newBullets = playerBullets.filter({ (b) -> Bool in return (b.position.y < 1000) })
//        self.playerBullets = Set(newBullets)
//        print(playerBullets.count)
        
//        if (abs(currentTime - self.startTime!) - nextWaveTime < 0.001) {
//            nextWaveTime = self.waveTimes.filter({$0 > nextWaveTime}).first!
//        }
//        
//        print(nextWaveTime)
    }
    
    func makeNewBulletPosition (playerPosition: CGPoint) -> CGPoint {
        return CGPoint(x: playerPosition.x, y: playerPosition.y+48)
    }
}
