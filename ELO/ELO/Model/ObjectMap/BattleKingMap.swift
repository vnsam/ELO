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
    let uniqueKingNames = Set.init(attackerKingNames + defenderKingNames)
    let uniqueKings = Array.init(uniqueKingNames).map { King.init(name: $0) }
    debugPrint("Filtered unique Kings: \(uniqueKings.map { $0.name })")
    for battle in battles {
        guard let attackerKing = uniqueKings.filter ({ $0.name == battle.attackerking }).first,
                let defenderKing = uniqueKings.filter ({ $0.name == battle.defenderking }).first else {
                    return
        }
        //  Battles
        attackerKing.battlesFought.append(battle)
        defenderKing.battlesFought.append(battle)
        // Won, Lost
        if Constants.Battle.AttackerOutcome.win == battle.attackerOutcome {
            attackerKing.won += 1
            defenderKing.lost += 1
        } else {
            defenderKing.won += 1
            attackerKing.lost += 1
        }
        // Attacks, Defenses
        attackerKing.numberOFDefenses += 1
        defenderKing.numberOfAttacks += 1
    }
    debugPrint("Finished parsing...")
}
