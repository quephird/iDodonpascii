//
//  GameState.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/14/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class GameState {
    var currentLevel: Int? = nil,
        startTime: CFTimeInterval? = nil

    func startGame() {
        self.startTime = CACurrentMediaTime()
        self.currentLevel = 1
    }
}