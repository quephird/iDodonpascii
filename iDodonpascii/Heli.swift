//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: SKSpriteNode, GameSprite {
    var flyAnimation = SKAction()

    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 96)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.position = position
        self.runAction(flyAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
    }

    func createAnimations() {
        let animationFrames:[SKTexture] = [
                textureAtlas.textureNamed("heli1.png"),
                textureAtlas.textureNamed("heli2.png")
            ],
            flightPath = createPath(self.position, direction: Direction.Right)
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.25)
        flyAnimation = SKAction.repeatActionForever(animationAction)
        self.runAction(SKAction.followPath(flightPath.CGPath, duration: 3.0))
    }
    
    func createPath(startingPoint: CGPoint, direction: Direction) -> UIBezierPath {
        // TODO: direction needs to be "pushed" into this object somehow and then utilized below.
        let path = UIBezierPath(),
            endingPoint = CGPoint(x: startingPoint.x+200.0, y: startingPoint.y),
            controlPoint = CGPoint(x: startingPoint.x+100.0, y: startingPoint.y-400.0)
        path.moveToPoint(startingPoint)
        path.addQuadCurveToPoint(endingPoint, controlPoint: controlPoint)
        return path
    }

    func onTap() {}
}