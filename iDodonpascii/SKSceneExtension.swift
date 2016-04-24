//
// Created by danielle kefford on 4/24/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

import SpriteKit

extension SKScene {
//    func computeProperScale(scene: SKScene, backgroundImage: SKSpriteNode) -> CGFloat {
//        return max(scene.size.width/backgroundImage.size.width,
//                   scene.size.height/backgroundImage.size.height)
//    }
    func computeProperScale(backgroundImage: SKSpriteNode) -> CGFloat {
        return max(self.size.width/backgroundImage.size.width,
                   self.size.height/backgroundImage.size.height)
    }
}
