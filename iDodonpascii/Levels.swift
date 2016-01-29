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
                  ["type": "heli",
                   "initParams": [(0.0, 600.0, 0.0, Direction.Right, 1),
                                  (100.0, 600.0, 0.0, Direction.Right, 1)]],
              5.0:
                  ["type": "heli",
                   "initParams": [(400.0, 600.0, 0.0, Direction.Left, 1),
                                  (300.0, 600.0, 0.0, Direction.Left, 1),
                                  (200.0, 600.0, 0.0, Direction.Left, 1)]],
              8.0:
                  ["type": "heli",
                   "initParams": [(0.0, 600.0, 0.0, Direction.Right, 1),
                                  (100.0, 600.0, 0.0, Direction.Right, 1),
                                  (200.0, 600.0, 0.0, Direction.Right, 1)]],
              11.0:
                  ["type": "heli",
                   "initParams": [(400.0, 600.0, 0.0, Direction.Left, 1),
                                  (300.0, 600.0, 0.0, Direction.Left, 1),
                                  (200.0, 600.0, 0.0, Direction.Left, 1)]],
             ]
         ]
    ]

