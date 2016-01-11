//
//  Levels.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/5/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

var levels: Dictionary<Int, Dictionary<String, Dictionary<Double, Dictionary<String, Any>>>> =
    [1:
         ["waves":
             [2.0:
                  ["type": Enemy.Heli,
                   "initParams": [(100, -100, 0, Direction.Right, 1),
                                  (200, -100, 0, Direction.Right, 1)]],
              5.0:
                  ["type": Enemy.Heli,
                   "initParams": [(1100, -100, 0, Direction.Left, 1),
                                  (1000, -100, 0, Direction.Left, 1),
                                  (900, -100, 0, Direction.Left, 1)]],
              8.0:
                  ["type": Enemy.Heli,
                   "initParams": [(100, -100, 0, Direction.Right, 1),
                                  (200, -100, 0, Direction.Right, 1),
                                  (300, -100, 0, Direction.Right, 1)]]]]]

