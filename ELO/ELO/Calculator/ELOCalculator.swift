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
    class func calculate(opponentScore: Double, wins: Int, losses: Int) -> Double {
        //  Wins + Loses ==> Number of games 
        let performanceScore = (opponentScore + Constants.ELO.factor)
            * Double((wins - losses)) / Double((wins + losses)).rounded()
        return performanceScore
    }
}
