//
//  SpawnManager.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/11/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

// This class needs to:
//   * Know the current level
//   * Keep track of elapsed time in the current level
//   * Keep track of the next spawn time
//   * Load the spawn configuration for that level
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
        return waveTimes.filter { $0 > currentWaveTime }.first
    }
    
    func getNewWave(waveTime: Double) -> Dictionary<String, Any> {
        return levels[gameState!.currentLevel!]!["waves"]![waveTime]!
    }
    
    func spawnNewEnemies(newWave: Dictionary<String, Any>) {
        let newEnemyType = newWave["type"],
            newEnemyParameters = newWave["initParams"] as! Array<(Double, Double, Double, Direction, Int)>
        for (x,y,_,_,_) in newEnemyParameters {
            Heli().spawn(self.parentNode!, position: CGPoint(x: x, y: y))
        }
    }
}