//
//  EncounterManager.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/6/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

import SpriteKit

class EncounterManager {
    // Store your encounter file names:
    let encounterNames:[String] = [
          "Helis"
    ];

    // Each encounter is an SKNode, store an array:
    var encounters:[SKNode] = []

    init() {
        // Loop through each encounter scene:
        for encounterFileName in encounterNames {
            // Create a new node for the encounter:
            let encounter = SKNode()
    
            // Load this scene file into a SKScene instance:
            if let encounterScene = SKScene(fileNamed: encounterFileName) {
                // Loop through each placeholder, spawn the
                // appropriate game object:
                for placeholder in encounterScene.children {
                    if let node = placeholder as? SKNode {
                        switch node.name! {
                        case "Heli":
                            let heli = Heli()
                            heli.spawn(encounter, position: node.position)
                        default:
                            print("Name error: \(node.name)")
                        }
                    }
                }
            }

            // Add the populated encounter node to the array:
            encounters.append(encounter)
        }
    }

    // We will call this addEncountersToWorld function from
    // the GameScene to append all of the encounter nodes to the
    // world node from our GameScene:
    func addEncountersToWorld(world: SKNode) {
        for index in 0 ... encounters.count - 1 {
            // Spawn the encounters behind the action, with
            // increasing height so they do not collide:
            encounters[index].position = CGPoint(x: 100+index*100, y: 500)
            world.addChild(encounters[index])
        }
    }
}