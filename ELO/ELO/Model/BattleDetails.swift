//
//  Battle.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

protocol BattleDetails {
    var name: String { get set }
    var attackerking: String { get set }
    var defenderking: String { get set }
    var attackerOutcome: String { get set }
    var location: String { get set }
    var region: String { get set }
}
