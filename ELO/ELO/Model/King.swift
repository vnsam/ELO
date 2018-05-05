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
    var totalOpponents: Int { get }
    var battles: [Battle] { get }
}

class King {
}
