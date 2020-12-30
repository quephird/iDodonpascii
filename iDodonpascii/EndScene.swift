//
// Created by danielle kefford on 4/18/16.
// Copyright (c) 2016 danielle kefford. All rights reserved.
//

//
//  StartScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/2/16.
//  Copyright © 2016 danielle kefford. All rights reserved.

import SpriteKit

class EndScene: SKScene {
    override func didMove(to view: SKView) {
        let startingPosition = CGPoint(x: 0.5*self.size.width, y: 0.5*self.size.height)
        let endBackground = Background(textureName: "end.png",
                                       startingPosition: startingPosition)
        endBackground.setScale(self.computeProperScale(backgroundImage: endBackground))
        self.addChild(endBackground)

        let waitAction = SKAction.wait(forDuration: 3.0)
        let switchSceneAction = SKAction.run {
            self.switchScene()
        }
        let entireAction = SKAction.sequence([waitAction, switchSceneAction])
        self.run(entireAction)
    }

    func switchScene() {
        let nextScene = StartScene(size: self.size)
        let transition = SKTransition.crossFade(withDuration: 1.0)
        self.scene!.view?.presentScene(nextScene, transition: transition)
    }
}
