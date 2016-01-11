//
//  Spawnable.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/8/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

protocol Spawnable {
    var textureAtlas: SKTextureAtlas { get set }
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize)
}
