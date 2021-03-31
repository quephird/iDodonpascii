//
//  ExtraShotPowerup.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 3/29/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation
import SpriteKit

class ExtraShotPowerup: SKSpriteNode, GameSprite {
    var animationFrames: [SKTexture] = []
    var initialPosition: CGPoint

    init(_ initialPosition: CGPoint) {
        self.initialPosition = initialPosition
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize())
        self.name = "Star"
        self.animationFrames = [
            textureAtlas.textureNamed("extraShotPowerup.png")
        ]
        self.size = CGSize(width: 32, height: 32)
        self.position = initialPosition
        self.zPosition = 100

        self.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask    = PhysicsCategory.OneThousand.rawValue
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
        print("(x,y): \(self.position.x), \(self.position.y)")

        // This is the equation of a cycloid
        let loopPath = SKAction.customAction(withDuration: 20.0) { node, currentTime in
            let dx = 100.0*cos(currentTime) - 100
            let dy = -100.0*sin(currentTime) - 50.0*currentTime
            node.position.x = self.initialPosition.x + dx
            node.position.y = self.initialPosition.y + dy
        }
        self.run(loopPath)
    }

    func createPath() -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0, y: -1000.0))
        return path
    }
}
