//
//  ELOCalculator.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

/*
 Abstract: Formula from: https://en.wikipedia.org/wiki/Elo_rating_system
*/
class ELOCalculator {
    class func update(attacker: King, defender: King, attackerWon: Bool) {
        var r1: Double = attacker.eloScore
        var r2: Double = defender.eloScore
        
        r1 = pow(10, (r1 / Constants.ELO.factor))
        r2 = pow(10, (r2 / Constants.ELO.factor))
        
        var expectedScoreR1: Double = 0.0
        var expectedScoreR2: Double = 0.0
        
        expectedScoreR1 = r1 / (r1 + r2)
        expectedScoreR2 = r2 / (r1 + r2)
    
        /*
         r'(1) = r(1) + K * (S(1) – E(1))
         r'(2) = r(2) + K * (S(2) – E(2))
        */
        
        if attackerWon {
            r1 = attacker.eloScore + Constants.ELO.K * (Constants.ELO.winScore - expectedScoreR1)
            r2 = defender.eloScore + Constants.ELO.K * (Constants.ELO.loseScore - expectedScoreR2)
        } else {
            r1 = attacker.eloScore + Constants.ELO.K * (Constants.ELO.loseScore - expectedScoreR1)
            r2 = defender.eloScore + Constants.ELO.K * (Constants.ELO.winScore - expectedScoreR2)
        }
    
        attacker.eloScore = r1
        defender.eloScore = r2
    }
}
