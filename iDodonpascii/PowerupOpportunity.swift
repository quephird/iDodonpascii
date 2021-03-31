//
//  PowerupOpportunity.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 3/28/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class PowerupOpportunity: SKSpriteNode {
    var baddieCount: Int

    init(_ initialBaddieCount: Int) {
        self.baddieCount = initialBaddieCount
        super.init(texture: SKTexture(),
                   color: UIColor.clear,
                   size: CGSize())
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
