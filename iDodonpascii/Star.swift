//
//  Star.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 3/25/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class Star: SKSpriteNode, GameSprite, Scrubbable {
    let points = 50
    var animationFrames: [SKTexture] = []

    init(_ initialPosition: CGPoint) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
        self.name = "Star"
        self.animationFrames = [
            textureAtlas.textureNamed("star1.png"),
            textureAtlas.textureNamed("star2.png")
        ]
        self.size = CGSize(width: 75, height: 75)
        self.position = initialPosition
        self.zPosition = 100

        self.physicsBody = SKPhysicsBody(circleOfRadius: 0.5*self.size.width)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.Star.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player.rawValue
        self.physicsBody?.collisionBitMask   = PhysicsCategory.None.rawValue

        let alwaysUpConstraint = SKConstraint.zRotation(SKRange(constantValue: 0))
        self.constraints = [alwaysUpConstraint]
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animateAndMove() {
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.25)
        self.run(SKAction.repeatForever(animationAction))

        let flightPath = self.createPath()
        let flightPathAction = SKAction.follow(flightPath, duration: 6.0)
        self.run(flightPathAction)
    }

    func createPath() -> CGPath {
        let path = CGMutablePath()
        let dx = CGFloat.random(in: -100...100)
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: dx, y: -1000.0))
        return path
    }
}
