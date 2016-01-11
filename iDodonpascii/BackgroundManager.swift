//
//  Background.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class BackgroundManager: GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"iDodonpascii.atlas"),
        parentNode = SKNode(),
        currentBackgroundNode = SKSpriteNode(),
        currentBackgroundNodeNext = SKSpriteNode()
    
    let backgrounds: [Int: String] = [
        1: "background1.png"
    ]
    
    // Time of last frame
    var lastFrameTime : NSTimeInterval = 0
        // Time since last frame
    var deltaTime : NSTimeInterval = 0
    
    func spawn(parentNode: SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 800, height: 1400)) {
        self.parentNode = parentNode

            // Prepare the sky sprites
        currentBackgroundNode = SKSpriteNode(texture: textureAtlas.textureNamed("background1.png"))
        currentBackgroundNode.position = CGPoint(x: size.width / 4.0, y: size.height / 4.0)
        currentBackgroundNode.setScale(0.5)
        
        currentBackgroundNodeNext = currentBackgroundNode.copy() as! SKSpriteNode
        currentBackgroundNodeNext.position =
            CGPoint(x: currentBackgroundNode.position.x,
                    y: currentBackgroundNode.position.y + currentBackgroundNode.size.height)
        currentBackgroundNodeNext.setScale(0.5)
        
        // Add the sprites to the scene
        parentNode.addChild(currentBackgroundNode)
        parentNode.addChild(currentBackgroundNodeNext)
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
        self.moveSprite(currentBackgroundNode,
                        nextSprite:currentBackgroundNodeNext,
                        speed: 200.0)
    }    
}