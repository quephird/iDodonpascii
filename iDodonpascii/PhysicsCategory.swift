//
// Created by danielle kefford on 4/5/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

enum PhysicsCategory: UInt32 {
    case None         = 0b0
    case PlayerBullet = 0b1
    case EnemyBullet  = 0b10
    case Player       = 0b100
    case Enemy        = 0b1000
}