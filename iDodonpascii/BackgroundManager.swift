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

        let topX = 0.5*UIScreen.main.bounds.width
        let topY = 1.5*UIScreen.main.bounds.height
        let topStartingPosition = CGPoint(x: topX, y: topY)
        self.topBackgroundNode = Background(textureName: currentBackgroundTexture!,
                                             startingPosition: topStartingPosition)

        let bottomX = 0.5*UIScreen.main.bounds.width
        let bottomY = 0.5*UIScreen.main.bounds.height
        let bottomStartingPosition = CGPoint(x: bottomX, y: bottomY)
        self.bottomBackgroundNode = Background(textureName: currentBackgroundTexture!,
                                                startingPosition: bottomStartingPosition)
    }

    func spawnBackgrounds() {
        for node in [self.topBackgroundNode!, self.bottomBackgroundNode!] {
            self.world!.addChild(node)
            node.setScale(self.world!.size.height/node.size.height)

            let dy = -UIScreen.main.bounds.height
            let dl = CGVector(dx: 0.0, dy: dy)
            let moveAction = SKAction.move(by: dl, duration: 3.0)
            let resetPositionAction = SKAction.run {
                node.position = node.startingPosition!
            }
            let loopAction = SKAction.sequence([moveAction, resetPositionAction])
            node.run(SKAction.repeatForever(loopAction))
        }
    }
}
