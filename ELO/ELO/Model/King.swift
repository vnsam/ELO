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
    var totalOpponents: Int { get } // You might not need this each battle will have an opponent - Clarify
    var battles: [Battle] { get }
    var attacks: Int { get }
    var defenses: Int { get }
}

class King: KingDetails {
    var name: String = ""
    var battlesWon: Int {
        return won
    }
    var battlesLost: Int {
        return lost
    }
    var totalOpponents: Int {
        return battles.count // Follow up on the comment above
    }
    var battles: [Battle] {
        return battlesFought
    }
    var attacks: Int {
        return numberOfAttacks
    }
    var defenses: Int {
        return numberOFDefenses
    }
    // MARK: - Properties
    var won = 0
    var lost = 0
    var battlesFought: [Battle] = []
    var numberOfAttacks: Int = 0
    var numberOFDefenses: Int = 0
    // MARK: - Init
    init(name: String) {
        self.name = name
    }
}
