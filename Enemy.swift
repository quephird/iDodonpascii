//
//  Enemy.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/5/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// TODO: Determine if the Enemy enum is still necessary
enum Direction {
    case Left
    case Right
}

enum Enemy {
    case Heli(CGFloat, CGFloat, CGFloat, Direction, Int)
    case Biplane(CGFloat, CGFloat, CGFloat, Direction, Int)
}

