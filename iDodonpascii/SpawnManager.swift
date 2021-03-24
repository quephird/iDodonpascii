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
        self.nextWaveTime = waveTimes.min()
    }

    func checkForSpawnableEnemies(elapsedTime: CFTimeInterval) {
        if elapsedTime >= nextWaveTime! {
            let newWave = getNewWave(waveTime: nextWaveTime!)
            spawnNewEnemies(newWave: newWave)
            self.nextWaveTime = getNextWaveTime(currentWaveTime: elapsedTime)
        }
    }

    func getNextWaveTime(currentWaveTime: CFTimeInterval) -> Double? {
        return waveTimes.filter { $0 > currentWaveTime }.sorted().first
    }
    
    func getNewWave(waveTime: Double) -> Dictionary<String, Any> {
        return levels[gameState!.currentLevel!]!["waves"]![waveTime]!
    }
    
    func spawnNewEnemies(newWave: Dictionary<String, Any>) {
        let newEnemyType = newWave["type"] as? String,
            newEnemyParameters = newWave["initParams"] as! Array<(Double, Double, Double, Direction)>
        for (initialX, initialY, spawnDelay, direction) in newEnemyParameters {
            let initParms = EnemyInitializationParameters(
                world: self.parentNode!,
                initialX: Double(UIScreen.main.bounds.width)*initialX,
                initialY: Double(UIScreen.main.bounds.height)*initialY,
                spawnDelay: spawnDelay,
                direction: direction
            )
            switch newEnemyType {
            case "heli"?:
                let newHeli = Heli(initParms: initParms)
                newHeli.spawn()
            case "biplane"?:
                let newBiplane = Biplane(initParms: initParms)
                newBiplane.spawn()
            case "pinkPlane"?:
                let newPinkPlane = PinkPlane(initParms: initParms)
                newPinkPlane.spawn()
            case "bluePlane"?:
                let newBluePlane = BluePlane(initParms: initParms)
                newBluePlane.spawn()
            default:
                break
            }
        }
    }
    
    // TODO: Need to improve method of determining which nodes to scrub;
    //       we're waaaaaay too dependent on magic numbers and hidden
    //       dependence on the starting and ending points of enemy paths.
    func clearOffscreenEnemies () {
        self.parentNode?.enumerateChildNodes(withName: "*", using: { (node, stop) -> Void in
            if let _ = node as? Scrubbable {
                if node.position.y < -0.20*UIScreen.main.bounds.height ||
                    node.position.y > 1.20*UIScreen.main.bounds.height ||
                    node.position.x < -0.20*UIScreen.main.bounds.width ||
                    node.position.x > 1.20*UIScreen.main.bounds.width {
                    node.removeFromParent()
                }
            }
        })
    }
}
