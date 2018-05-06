//
//  BattleInfo.swift
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

class Battle: BattleDetails, Decodable {
    var name: String {
        get {
            return attributes[CodingKeys.name.rawValue] as? String ?? ""
        } set(value) {
            self.name = value
        }
    }
    var attackerking: String {
        get {
            return attributes[CodingKeys.attackerking.rawValue] as? String ?? ""
        } set(value) {
            self.attackerking = value
        }
    }
    var defenderking: String {
        get {
            return attributes[CodingKeys.defenderking.rawValue] as? String ?? ""
        } set(value) {
            self.defenderking = value
        }
    }
    var attackerOutcome: String {
        get {
            return attributes[CodingKeys.attackeroutcome.rawValue] as? String ?? ""
        } set(value) {
            self.attackerOutcome = value
        }
    }
    var location: String {
        get {
            return attributes[CodingKeys.location.rawValue] as? String ?? ""
        } set(value) {
            self.location = value
        }
    }
    var region: String {
        get {
            return attributes[CodingKeys.region.rawValue] as? String ?? ""
        } set(value) {
            self.region = value
        }
    }
    fileprivate var attributes: [AnyHashable: Any?]
    // FIXME: - attackerKing, defenderKing - should be a part of BattleInfo protocol. (todo)
    fileprivate var attackerKing: King {
        return King.init(name: attributes[CodingKeys.attackerking.rawValue] as? String ?? "")
    }
    fileprivate var defenderKing: King {
        return King.init(name: attributes[CodingKeys.defenderking.rawValue] as? String ?? "")
    }
    // MARK: - Init
    init(attributes: [AnyHashable: Any?]) {
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
    public required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var attributes: [AnyHashable: Any?] = [:]
        for codingKey in CodingKeys.all {
            let key = codingKey.rawValue
            attributes[key] = try values.decodeIfPresent(String.self, forKey: codingKey)
        }
        self.init(attributes: attributes)
    }
}
