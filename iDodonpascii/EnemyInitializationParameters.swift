//
// Created by danielle kefford on 4/11/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

struct EnemyInitializationParameters {
    var world: SKNode
    var initialX: Double
    var initialY: Double
    var spawnDelay: Double
    var direction: Direction
    var hitPoints: Int
}