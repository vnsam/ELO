//
//  BattleKingMap.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class BattleKingMap {
    class func mapKingToBattles(_ battles: [Battle]) -> [King]? {
        let attackerKingNames = battles.map { $0.attackerking }
        let defenderKingNames = battles.map { $0.defenderking }
        /*
         I do see some nameless kings in JSON. Trimming these nameless kings. | ON SET |
         */
        let uniqueKingNames = Set.init(attackerKingNames + defenderKingNames).filter { $0.count > 0 }
        let uniqueKings = Array.init(uniqueKingNames).map { King.init(name: $0) }
        for battle in battles {
            if let attackerKing = uniqueKings.filter ({ $0.name == battle.attackerking }).first,
                let defenderKing = uniqueKings.filter ({ $0.name == battle.defenderking }).first  {
             
                //  Battles
                attackerKing.addBattle(battle)
                defenderKing.addBattle(battle)
                // Won, Lost
                if Constants.Battle.AttackerOutcome.win == battle.attackerOutcome {
                    attackerKing.battlesWon += 1
                    defenderKing.battlesLost += 1
                } else {
                    defenderKing.battlesWon += 1
                    attackerKing.battlesLost += 1
                }
                // Attacks, Defenses
                attackerKing.attacks += 1
                defenderKing.defenses += 1
                // Elo Score
                /*
                attackerKing.eloScore = ELOCalculator
                    .calculate(opponentScore: defenderKing.eloScore,
                               wins: defenderKing.battlesWon, losses: defenderKing.battlesLost)
                defenderKing.eloScore = ELOCalculator
                    .calculate(opponentScore: attackerKing.eloScore,
                               wins: attackerKing.battlesWon, losses: attackerKing.battlesLost)
                */
                ELOCalculator.update(attacker: attackerKing, defender: defenderKing, attackerWon: Constants.Battle.AttackerOutcome.win == battle.attackerOutcome)
            }
        }
        return uniqueKings
    }
}
