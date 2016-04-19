//
//  StartScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/2/16.
//  Copyright © 2016 danielle kefford. All rights reserved.

import SpriteKit

class StartScene: SKScene {
    override func didMoveToView(view: SKView) {
        let startingPosition = CGPoint(x: 0.5*self.size.width, y: 0.5*self.size.height)
        let startBackground = Background(textureName: "start.png",
                                         startingPosition: startingPosition)
        self.addChild(startBackground)

        let startGameButton = StartGameButton()
        startGameButton.spawn(self,
                              position: CGPoint(x: 0.5*self.size.width,
                                                y: 0.2*self.size.height))
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self),
                nodes = self.nodesAtPoint(location)

            for node in nodes {
                // TODO: I don't know if I like this; comparing names of things smells.
                if (node.name == "StartGameButton") {
                    self.switchScene()
                }
            }
        }
    }
    
    func switchScene() {
        let nextScene = GameScene(size: self.size)
        let transition = SKTransition.crossFadeWithDuration(1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
