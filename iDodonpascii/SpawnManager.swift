//
//  SpawnManager.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/11/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class needs to:
//   * Be able to access the entire current game state
//   * Load the spawn configuration for the current level
//   * Keep track of the next spawn time
//   * Be interrogated and know when to spawn new enemies

class SpawnManager {
    var gameState: GameState? = nil,
        parentNode: SKNode? = nil,
        waveTimes: [Double] = [],
        nextWaveTime: Double? = nil

    func beginSpawningEnemies(gameState: GameState,  parentNode: SKNode) {
        self.gameState = gameState
        self.parentNode = parentNode
        self.waveTimes = [Double](levels[gameState.currentLevel!]!["waves"]!.keys)
        self.nextWaveTime = waveTimes.minElement()
    }

    func checkForSpawnableEnemies(elapsedTime: CFTimeInterval) {
        if elapsedTime >= nextWaveTime {
            let newWave = getNewWave(nextWaveTime!)
            spawnNewEnemies(newWave)
            self.nextWaveTime = getNextWaveTime(elapsedTime)
        }
    }

    func getNextWaveTime(currentWaveTime: CFTimeInterval) -> Double? {
        return waveTimes.filter { $0 > currentWaveTime }.sort().first
    }
    
    func getNewWave(waveTime: Double) -> Dictionary<String, Any> {
        return levels[gameState!.currentLevel!]!["waves"]![waveTime]!
    }
    
    func spawnNewEnemies(newWave: Dictionary<String, Any>) {
        let newEnemyType = newWave["type"] as? String,
            newEnemyParameters = newWave["initParams"] as! Array<(Double, Double, Double, Direction, Double)>
        switch newEnemyType {
            case "heli"?:
                for (x, y, _, direction, _) in newEnemyParameters {
                    Heli(direction: direction).spawn(self.parentNode!, position: CGPoint(x: x, y: y))
                }
            case "biplane"?:
                for (x, y, _, direction, d) in newEnemyParameters {
                    let newBiplane = Biplane(direction: direction)
                    newBiplane.spawnDelay = d
                    newBiplane.spawn(self.parentNode!, position: CGPoint(x: x, y: y))
                }
            default:
                break
        }
    }
    
    func clearOffscreenEnemies () {
        self.parentNode?.enumerateChildNodesWithName("*", usingBlock: { (node, stop) -> Void in
            if let _ = node as? Scrubbable {
                if node.position.y < -100.0 || node.position.y > 750.0 ||
                   node.position.x < -100.0 || node.position.x > 500.0 {
                    node.removeFromParent()
                }
            }
        })
    }
}