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
              5.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              8.0:
                  ["type": "biplane",
                   "initParams": [(-100.0, 400.0, 0.0, Direction.Right, 1),
                                  (-100.0, 400.0, 0.4, Direction.Right, 1),
                                  (-100.0, 400.0, 0.8, Direction.Right, 1),
                                  (-100.0, 400.0, 1.2, Direction.Right, 1),
                                  (-100.0, 400.0, 1.6, Direction.Right, 1)]],
              11.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1),
                                  (100.0, 700.0, 0.0, Direction.Right, 1),
                                  (200.0, 700.0, 0.0, Direction.Right, 1)]],
              14.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              17.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              20.0:
                  ["type": "pinkPlane",
                   "initParams": [(50.0, 700.0, 0.0, Direction.Right, 1),
                                  (350.0, 700.0, 0.0, Direction.Left, 1)]],
              25.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              28.0:
                  ["type": "heli",
                   "initParams": [(0.0, 700.0, 0.0, Direction.Right, 1),
                                  (100.0, 700.0, 0.0, Direction.Right, 1),
                                  (200.0, 700.0, 0.0, Direction.Right, 1)]],
              31.0:
                  ["type": "biplane",
                   "initParams": [(500.0, 400.0, 0.0, Direction.Left, 1),
                                  (500.0, 400.0, 0.4, Direction.Left, 1),
                                  (500.0, 400.0, 0.8, Direction.Left, 1),
                                  (500.0, 400.0, 1.2, Direction.Left, 1),
                                  (500.0, 400.0, 1.6, Direction.Left, 1)]],
              34.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              37.0:
                  ["type": "bluePlane",
                   "initParams": [(-100.0, 600.0, 0.0, Direction.Right, 1),
                                  (-100.0, 500.0, 0.3, Direction.Right, 1),
                                  (-100.0, 400.0, 0.6, Direction.Right, 1),
                                  (-100.0, 300.0, 0.9, Direction.Right, 1)]],
              40.0:
                  ["type": "heli",
                   "initParams": [(400.0, 700.0, 0.0, Direction.Left, 1),
                                  (300.0, 700.0, 0.0, Direction.Left, 1),
                                  (200.0, 700.0, 0.0, Direction.Left, 1)]],
              43.0:
                  ["type": "bluePlane",
                   "initParams": [(500.0, 600.0, 0.0, Direction.Left, 1),
                                  (500.0, 500.0, 0.3, Direction.Left, 1),
                                  (500.0, 400.0, 0.6, Direction.Left, 1),
                                  (500.0, 300.0, 0.9, Direction.Left, 1)]],
              46.0:
                  ["type": "pinkPlane",
                   "initParams": [(50.0, 700.0, 0.0, Direction.Right, 1),
                                  (350.0, 700.0, 0.0, Direction.Left, 1)]],
                
             ]
         ]
    ]

