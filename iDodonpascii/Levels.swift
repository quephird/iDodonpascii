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
                   "initParams": [(100, 1000, 0, Direction.Right, 1),
                                  (200, 1000, 0, Direction.Right, 1)]],
              5.0:
                  ["type": Enemy.Heli,
                   "initParams": [(700, 1000, 0, Direction.Left, 1),
                                  (600, 1000, 0, Direction.Left, 1),
                                  (500, 1000, 0, Direction.Left, 1)]],
              8.0:
                  ["type": Enemy.Heli,
                   "initParams": [(100, 1000, 0, Direction.Right, 1),
                                  (200, 1000, 0, Direction.Right, 1),
                                  (300, 1000, 0, Direction.Right, 1)]],
             ]
         ]
    ]

