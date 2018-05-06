//
//  BattleKingMap.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

func mapKingToBattles(_ battles: [Battle]) {
    let attackerKingNames = battles.map { $0.attackerking }
    let defenderKingNames = battles.map { $0.defenderking }
    let uniqueKingNames = Set.init(attackerKingNames + defenderKingNames).filter { $0.count > 0 } // I do see some nameless kings in JSON. Trimming these nameless kings.
    let uniqueKings = Array.init(uniqueKingNames).map { King.init(name: $0) }
    debugPrint("Filtered unique Kings: \(uniqueKings.map { $0.name })")
    for battle in battles {
        guard let attackerKing = uniqueKings.filter ({ $0.name == battle.attackerking }).first,
                let defenderKing = uniqueKings.filter ({ $0.name == battle.defenderking }).first else {
                    return
        }
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
        attackerKing.defenses += 1
        defenderKing.attacks += 1
        // Elo Score
        attackerKing.eloScore = ELOCalculator
            .calculate(opponentScore: defenderKing.eloScore,
                       wins: defenderKing.battlesWon, losses: defenderKing.battlesLost)
        defenderKing.eloScore = ELOCalculator
            .calculate(opponentScore: attackerKing.eloScore,
                       wins: attackerKing.battlesWon, losses: attackerKing.battlesLost)
    }
    debugPrint("Finished parsing...")
}
