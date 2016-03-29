//
//  GameState.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/14/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class maintains all state information vital to the game.

class GameState {
    var currentLevel: Int? = nil,
        startTime: CFTimeInterval? = nil,
        score: UInt? = nil,
        lives: Int? = nil

    func startGame() {
        self.startTime = CACurrentMediaTime()
        self.currentLevel = 1
        self.score = 0
        self.lives = 3
    }
}