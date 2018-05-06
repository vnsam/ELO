//
//  BattleScore.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

protocol BattleScore {
    var eloScore: Double { get set } // Might expect a bigger number in score - Hence Double (for real world). Float can also satisfy. 
}
