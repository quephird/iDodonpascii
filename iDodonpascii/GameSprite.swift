//
//  GameSprite.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/3/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get }
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize)
}

extension GameSprite {
    var textureAtlas: SKTextureAtlas {
        return SKTextureAtlas(named:"iDodonpascii.atlas")
    }
}
