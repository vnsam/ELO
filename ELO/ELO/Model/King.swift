//
//  King.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

protocol KingDetails {
    var name: String { get }
    var battlesWon: Int { get }
    var battlesLost: Int { get }
    var totalOpponents: Int { get }
    var battles: [Battle] { get }
}

class King: KingDetails {
    var name: String = ""
    var battlesWon: Int = 0
    var battlesLost: Int = 0
    var totalOpponents: Int = 0
    var battles: [Battle] = []
    fileprivate (set)var battlesFought: [Battle] = []
    init(name: String) {
        self.name = name
    }
}
