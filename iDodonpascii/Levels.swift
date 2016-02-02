//
//  Levels.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/5/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// For now, this file contains just a structure containing all data
// describing the enemies to be spawned in the game.

var levels: Dictionary<Int, Dictionary<String, Dictionary<Double, Dictionary<String, Any>>>> =
    [1:
        ["waves":
             [2.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1),
                                  (100.0, 700.0, 0.0, Direction.Right, 1)]],
              6.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              10.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1),
                                  (100.0, 700.0, 0.0, Direction.Right, 1),
                                  (200.0, 700.0, 0.0, Direction.Right, 1)]],
              14.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
             ]
         ]
    ]

