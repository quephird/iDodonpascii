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

// TODO: Figure out how to scale (x,y) coords based on resolution of device;
//       possibly use proportions instead of absolute coordinates.
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
              5.0:
                  ["type": "biplane",
                   "initParams": [(-100.0, 500.0, 0.0, Direction.Right, 1),
                                  (-100.0, 500.0, 0.5, Direction.Right, 1),
                                  (-100.0, 500.0, 1.0, Direction.Right, 1)]],
              24.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              28.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1),
                                  (100.0, 700.0, 0.0, Direction.Right, 1),
                                  (200.0, 700.0, 0.0, Direction.Right, 1)]],
             ]
         ]
    ]

