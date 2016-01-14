//
//  Background.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class needs to:
//   * Know the current level
//   * Select proper background image for that level
//   * Spawn two sprites for that image
//   * Place and move them such that there is a continuous vertically scrolling background.

class BackgroundManager {
    var parentNode = SKNode(),
        currentBackgroundNode: Background? = nil,
        currentBackgroundNodeNext: Background? = nil,
        lastFrameTime : NSTimeInterval = 0,
        deltaTime : NSTimeInterval = 0
    
    let backgrounds: [Int: String] = [
        1: "background1.png"
    ]
    
    func spawnBackgrounds(currentLevel: Int, parentNode: SKNode) {
        self.currentBackgroundNode = Background(textureName: self.backgrounds[currentLevel]!)
        self.currentBackgroundNode!.spawn(parentNode,
                                          position: CGPoint(x: currentBackgroundNode!.size.width / 4.0,
                                                            y: currentBackgroundNode!.size.height / 4.0))
        self.currentBackgroundNodeNext = currentBackgroundNode!.copy() as? Background
        self.currentBackgroundNodeNext!.spawn(parentNode,
                                             position: CGPoint(x: currentBackgroundNode!.position.x,
                                                               y: currentBackgroundNode!.position.y + currentBackgroundNode!.size.height))
    }
    
    // Move a pair of sprites downward based on a speed value;
    // when either of the sprites goes off-screen, move it to the
    // right so that it appears to be seamless movement
    func moveSprite(sprite : SKSpriteNode,
                    nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPointZero

        // For both the sprite and its duplicate:
        for spriteToMove in [sprite, nextSprite] {
            
            // Shift the sprite downward based on the speed
            newPosition = spriteToMove.position
            newPosition.y -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            // If this sprite is now offscreen (i.e., its topmost edge is
            // farther down than the scene's downmost edge):
            if spriteToMove.frame.maxY < self.parentNode.frame.minY {
                
                // Shift it over so that it's now to the immediate top
                // of the other sprite. This means that the two sprites 
                // are effectively leap-frogging each other as they both move.
                spriteToMove.position =
                    CGPoint(x: spriteToMove.position.x,
                            y: spriteToMove.position.y + spriteToMove.size.height * 2)
            }
        }
    }
    
    func update(currentTime: NSTimeInterval) {
        // First, update the delta time values:
        
        // If we don't have a last frame time value, this is the first frame,
        // so delta time will be zero.
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the four pairs of sprites.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(currentBackgroundNode!,
                        nextSprite: currentBackgroundNodeNext!,
                        speed: 200.0)
    }    
}