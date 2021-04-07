//
//  GameState.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/14/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class maintains all state information vital to the game.

class GameState: Consumer {
    var currentLevel: Int? = nil,
        startTime: CFTimeInterval? = nil,
        score: UInt = 0,
        lives: Int = 0

    var grazes: UInt = 0
    var kills: UInt = 0
    var livesLost: UInt = 0
    var stars: UInt = 0
    var shots: UInt = 0

    func startGame() {
        self.startTime = CACurrentMediaTime()
        self.currentLevel = 1
        self.lives = 3
    }

    func notify(_ messageType: MessageType) {
        switch messageType {
        case .EnemyBulletGrazed:
            self.grazes += 1
        case .EnemyDied:
            self.kills += 1
        case .PlayerBulletFired:
            self.shots += 1
        case .StarCollected:
            self.stars += 1
        case .PlayerDied:
            self.livesLost += 1
        default:
            ()
        }
    }
}
