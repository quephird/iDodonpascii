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

// TODO: Remove hit point configuration from here
var levels: Dictionary<Int, Dictionary<String, Dictionary<Double, Dictionary<String, Any>>>> =
    [1:
        ["waves":
             [2.0:
                  ["type": "heli",
                   "initParams": [(0.00, 0.95, 0.0, Direction.Right),
                                  (0.20, 0.95, 0.0, Direction.Right)]],
              5.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              8.0:
                  ["type": "biplane",
                   "initParams": [(-0.05, 0.55, 0.0, Direction.Right),
                                  (-0.05, 0.55, 0.4, Direction.Right),
                                  (-0.05, 0.55, 0.8, Direction.Right),
                                  (-0.05, 0.55, 1.2, Direction.Right),
                                  (-0.05, 0.55, 1.6, Direction.Right)]],
              11.0:
                  ["type": "heli",
                   "initParams": [(0.00, 0.95, 0.0, Direction.Right),
                                  (0.20, 0.95, 0.0, Direction.Right),
                                  (0.40, 0.95, 0.0, Direction.Right)]],
              14.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              17.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              20.0:
                  ["type": "pinkPlane",
                   "initParams": [(0.10, 0.95, 0.0, Direction.Right),
                                  (0.90, 0.95, 0.0, Direction.Left)]],
              25.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              28.0:
                  ["type": "heli",
                   "initParams": [(0.00, 0.95, 0.0, Direction.Right),
                                  (0.20, 0.95, 0.0, Direction.Right),
                                  (0.40, 0.95, 0.0, Direction.Right)]],
              31.0:
                  ["type": "biplane",
                   "initParams": [(1.05, 0.55, 0.0, Direction.Left),
                                  (1.05, 0.55, 0.4, Direction.Left),
                                  (1.05, 0.55, 0.8, Direction.Left),
                                  (1.05, 0.55, 1.2, Direction.Left),
                                  (1.05, 0.55, 1.6, Direction.Left)]],
              34.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              37.0:
                  ["type": "bluePlane",
                   "initParams": [(-0.07, 0.90, 0.0, Direction.Right),
                                  (-0.07, 0.80, 0.3, Direction.Right),
                                  (-0.07, 0.70, 0.6, Direction.Right),
                                  (-0.07, 0.60, 0.9, Direction.Right)]],
              40.0:
                  ["type": "heli",
                   "initParams": [(1.00, 0.95, 0.0, Direction.Left),
                                  (0.80, 0.95, 0.0, Direction.Left),
                                  (0.60, 0.95, 0.0, Direction.Left)]],
              43.0:
                  ["type": "bluePlane",
                   "initParams": [(1.07, 0.90, 0.0, Direction.Left),
                                  (1.07, 0.80, 0.3, Direction.Left),
                                  (1.07, 0.70, 0.6, Direction.Left),
                                  (1.07, 0.60, 0.9, Direction.Left)]],
              46.0:
                  ["type": "pinkPlane",
                   "initParams": [(0.10, 0.95, 0.0, Direction.Right),
                                  (0.90, 0.95, 0.0, Direction.Left)]],
                
             ]
         ]
    ]

