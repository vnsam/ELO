//
//  King.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class King: BattlePlayer, BattleScore {
    typealias Role = String
    
    var rolePlayed: String {
        get {
            return String.init(describing: King.self)
        }
    }
    
    var role: Role!
    var name: String = ""
    var battlesWon: Int {
        get {
            return won
        } set(value) {
            self.won = value
        }
    }
    var battlesLost: Int {
        get {
            return lost
        } set(value) {
            self.lost = value
        }
    }
    var totalOpponents: Int {
        return battles.count // Follow up on the comment from Protocol - What if 2 kings fight against a king. This ain't accurate.
    }
    var battles: [Battle] {
        get {
            return battlesFought
        } set(value) {
            self.battles = value
        }
    }
    var attacks: Int {
        get {
            return numberOfAttacks
        } set(value) {
            self.numberOfAttacks = value
        }
    }
    var defenses: Int {
        get {
            return numberOFDefenses
        } set(value) {
            self.numberOFDefenses = value
        }
    }
    // MARK: - Properties
    private var won = 0
    private var lost = 0
    private var battlesFought: [Battle] = []
    private var numberOfAttacks: Int = 0
    private var numberOFDefenses: Int = 0
    internal var score: Double = Constants.ELO.initalRating
    // MARK: - Init
    init(name: String) {
        self.name = name
    }
    // MARK: - Setters
    func addBattle(_ battle: Battle) {
        self.battlesFought.append(battle)
    }
    // MARK: - BattleScore Implementation
    var eloScore: Double {
        get {
            return self.score
        } set(value) {
            self.score = value
        }
    }
}
