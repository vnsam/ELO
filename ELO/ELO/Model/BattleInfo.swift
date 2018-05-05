//
//  BattleInfo.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

protocol BattleDetails {
    var name: String { get }
    var attackerking: String { get }
    var defenderking: String { get }
    var attackerOutcome: String { get }
    var location: String { get }
    var region: String { get }
}

class Battle: BattleDetails {
    var name: String {
        return attributes[CodingKeys.name.rawValue] as? String ?? ""
    }
    var attackerking: String {
        return attributes[CodingKeys.attackerking.rawValue] as? String ?? ""
    }
    var defenderking: String {
        return attributes[CodingKeys.defenderking.rawValue] as? String ?? ""
    }
    var attackerOutcome: String {
        return attributes[CodingKeys.attackeroutcome.rawValue] as? String ?? ""
    }
    var location: String {
        return attributes[CodingKeys.location.rawValue] as? String ?? ""
    }
    var region: String {
        return attributes[CodingKeys.region.rawValue] as? String ?? ""
    }
    fileprivate var attributes: [AnyHashable: Any]
    // MARK: - Init
    init(attributes: [AnyHashable: Any]) {
        self.attributes = attributes
    }
    // MARK: - Decoding
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case attackerking = "attacker_king"
        case defenderking = "defender_king"
        case attackeroutcome = "attacker_outcome"
        case location = "location"
        case region = "region"
        static let all: [CodingKeys] = [.name, .attackerking, .defenderking,
                                        .attackeroutcome, .location, .region]
    }
}
