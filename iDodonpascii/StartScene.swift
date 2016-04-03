//
//  StartScene.swift
//  iDodonpascii
//
//  Created by danielle kefford on 4/2/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    override func didMoveToView(view: SKView) {
        let startBackground: Background = Background(textureName: "start.png")
        startBackground.spawn(self, position: CGPoint(x: startBackground.size.width / 4.0,
                                                      y: startBackground.size.height / 4.0))
        // TODO: Need to add blinking START GAME sprite
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            // TODO: Need to detect if START GAME node was touched
            let nextScene = GameScene(size: self.size)
            // TODO: I'm not sure I like this but it works.
            //       Need to think about better way to transition.
            let transition = SKTransition.flipVerticalWithDuration(1.0)
            self.scene!.view?.presentScene(nextScene, transition: transition)
        }
    }
}
