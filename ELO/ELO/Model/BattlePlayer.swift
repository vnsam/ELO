//
//  KingDetails.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

protocol BattlePlayer {
    associatedtype Role // Anyone confirming to Battleplayer will return the confirming type here.
    
    var rolePlayed: Role { get }
    var name: String { get set }
    var battlesWon: Int { get set }
    var battlesLost: Int { get set }
    var totalOpponents: Int { get } // You might not need this each battle will have an opponent - Clarify
    var battles: [Battle] { get set }
    var attacks: Int { get set }
    var defenses: Int { get set }
}
