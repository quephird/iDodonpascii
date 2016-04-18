//
//  Background.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class needs to:
//   * Be informed of the current level
//   * Select proper background image for that level
//   * Spawn two sprites for that image
//   * Place and move them such that there is a continuously vertical scrolling background.

class BackgroundManager {
    let backgroundTextures: [UInt: String] = [
            1: "background1.png"
    ]

    // TODO: I don't like this class having to hold a reference to world;
    //       the two background nodes should instead.
    var world: SKScene? = nil
    var currentLevel: UInt = 1
    var topBackgroundNode: Background? = nil
    var bottomBackgroundNode: Background? = nil

    init(world: SKScene) {
        self.world = world
        let currentBackgroundTexture = backgroundTextures[currentLevel]

        let topStartingPosition = CGPoint(x: 0.5*world.size.width, y: 1.5*world.size.height)
        self.topBackgroundNode = Background(textureName: currentBackgroundTexture!,
                                             startingPosition: topStartingPosition)

        let bottomStartingPosition = CGPoint(x: 0.5*world.size.width, y: 0.5*world.size.height)
        self.bottomBackgroundNode = Background(textureName: currentBackgroundTexture!,
                                                startingPosition: bottomStartingPosition)
    }

    func spawnBackgrounds() {
        for node in [self.topBackgroundNode!, self.bottomBackgroundNode!] {
            self.world!.addChild(node)
            let dy = CGVectorMake(0.0, -self.world!.size.height)
            let moveAction = SKAction.moveBy(dy, duration: 3.0)
            let resetPositionAction = SKAction.runBlock {
                node.position = node.startingPosition!
            }
            let loopAction = SKAction.sequence([moveAction, resetPositionAction])
            node.runAction(SKAction.repeatActionForever(loopAction))
        }
    }
}