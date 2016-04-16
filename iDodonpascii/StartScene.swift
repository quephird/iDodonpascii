//
//  StartScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/2/16.
//  Copyright © 2016 danielle kefford. All rights reserved.

import SpriteKit

class StartScene: SKScene {
    override func didMoveToView(view: SKView) {
        let startBackground: Background = Background(textureName: "start.png",
                                                     startingPosition: CGPoint(x: 0, y: 0))
        startBackground.spawn(self,
                              position: CGPoint(x: 0.25*startBackground.size.width,
                                                y: 0.25*startBackground.size.height),
                              size: self.size)

        let startGameButton = StartGameButton()
        startGameButton.spawn(self,
                              position: CGPoint(x: 0.5*startBackground.size.width,
                                                y: 0.2*startBackground.size.height))
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
        // TODO: I'm not sure I like this but it works.
        //       Need to think about better way to transition.
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
