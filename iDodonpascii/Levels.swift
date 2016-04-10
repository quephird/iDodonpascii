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

// TODO: Figure out how to scale (x,y) coords based on resolution of device
var levels: Dictionary<Int, Dictionary<String, Dictionary<Double, Dictionary<String, Any>>>> =
    [1:
        ["waves":
             [2.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1.0),
                                  (100.0, 700.0, 0.0, Direction.Right, 1.0)]],
              6.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (300.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (200.0, 700.0, 0.0, Direction.Left, 1.0)]],
              10.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1.0),
                                  (100.0, 700.0, 0.0, Direction.Right, 1.0),
                                  (200.0, 700.0, 0.0, Direction.Right, 1.0)]],
              14.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (300.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (200.0, 700.0, 0.0, Direction.Left, 1.0)]],
              5.0:
                  ["type": "biplane",
                   "initParams": [(-100.0, 500.0, 0.0, Direction.Right, 0.0),
                                  (-100.0, 500.0, 0.0, Direction.Right, 0.5),
                                  (-100.0, 500.0, 0.0, Direction.Right, 1.0)]],
              24.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (300.0, 700.0, 0.0, Direction.Left, 1.0),
                                  (200.0, 700.0, 0.0, Direction.Left, 1.0)]],
              28.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1.0),
                                  (100.0, 700.0, 0.0, Direction.Right, 1.0),
                                  (200.0, 700.0, 0.0, Direction.Right, 1.0)]],
             ]
         ]
    ]

