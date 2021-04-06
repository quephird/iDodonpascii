//
//  MessageServer.swift
//  iDodonpascii
//
//  Created by Danielle Kefford on 4/5/21.
//  Copyright © 2021 danielle kefford. All rights reserved.
//

import Foundation

class MessageServer {
    var registrations: Dictionary<MessageType, [Consumer]> = [:]

    func register(_ newConsumer: Consumer, forMessageType: MessageType) {
        if var consumers = registrations[forMessageType] {
            consumers.append(newConsumer)
        } else {
            self.registrations[forMessageType] = [newConsumer]
        }
    }

    func publish(messageType: MessageType) {
        if let consumers = registrations[messageType] {
            for consumer in consumers {
                consumer.notify(messageType)
            }
            self.registrations[messageType] = []
        }
    }
}
