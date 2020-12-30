//
//  StartScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/2/16.
//  Copyright © 2016 danielle kefford. All rights reserved.

import SpriteKit

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        let startingPosition = CGPoint(x: 0.5*self.size.width, y: 0.5*self.size.height)
        let startBackground = Background(textureName: "start.png",
                                         startingPosition: startingPosition)
        startBackground.setScale(self.computeProperScale(backgroundImage: startBackground))
        self.addChild(startBackground)

        let startGameButton = StartGameButton()
        startGameButton.spawn(parentNode: self,
                              position: CGPoint(x: 0.5*self.size.width,
                                                y: 0.2*self.size.height))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self),
                nodes = self.nodes(at: location)

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
        let transition = SKTransition.crossFade(withDuration: 1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
