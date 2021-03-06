//
//  Background.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/13/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode, GameSprite {
    var startingPosition: CGPoint? = nil

    init(textureName: String,
         startingPosition: CGPoint) {
        super.init(texture: SKTexture(),
                   color: UIColor.white,
                   size: CGSize())
        self.texture = textureAtlas.textureNamed(textureName)
        self.startingPosition = startingPosition
        self.position = startingPosition
        self.zPosition = 0
        self.name = "Background"
        self.size = self.texture!.size()
    }

    override init(texture: SKTexture!, color: (UIColor?), size: CGSize) {
        super.init(texture: texture, color: color ?? UIColor.white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not needed")
    }
}
