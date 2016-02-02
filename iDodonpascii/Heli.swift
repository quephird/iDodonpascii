//
//  Heli.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class Heli: SKSpriteNode, GameSprite, Enemy {
    var flyAnimation = SKAction()

    func spawn(parentNode:SKNode,
               position: CGPoint,
               size: CGSize = CGSize(width: 96, height: 96)) {
        parentNode.addChild(self)
        createAnimations()
        self.size = size
        self.name = "EnemyHeli"
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
            // The +5 is a tiny hack to ensure that the heli will go beyond the maximum y
            // such that it will be scrubbed.
            endingPoint = CGPoint(x: startingPoint.x+200.0, y: startingPoint.y+5),
            controlPoint = CGPoint(x: startingPoint.x+100.0, y: startingPoint.y-700.0)
        path.moveToPoint(startingPoint)
        path.addQuadCurveToPoint(endingPoint, controlPoint: controlPoint)
        return path
    }

    func onTap() {}
}