//
// Created by danielle kefford on 4/5/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

enum PhysicsCategory: UInt32 {
    case None         = 0b0
    case PlayerBullet = 0b1
    case EnemyBullet  = 0b10
    case Player       = 0b100
    case PlayerGraze  = 0b1000
    case Enemy        = 0b10000
    case Star         = 0b100000
    case OneThousand  = 0b1000000
    case ExtraShot    = 0b10000000
}
