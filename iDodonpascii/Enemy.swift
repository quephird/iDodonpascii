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

    init(initParms: EnemyInitializationParameters) {
        self.world = initParms.world
        self.spawnDelay = initParms.spawnDelay
        self.direction = initParms.direction
        self.hitPoints = initParms.hitPoints

        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
        self.position = CGPoint(x: initParms.initialX, y: initParms.initialY)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func explodeAndDie() {
        fatalError("explodeAndDie has not been implemented")
    }
}

