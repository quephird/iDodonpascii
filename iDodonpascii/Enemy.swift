//
//  Enemy.swift
//  iDodonpascii
//
//  Created by danielle kefford on 1/5/16.
//  Copyright © 2016 danielle kefford. All rights reserved.
//

protocol Enemy: Scrubbable {
    var points: UInt { get }
    func explodeAndDie()
}
