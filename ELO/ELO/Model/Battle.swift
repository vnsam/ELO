//
//  BattleInfo.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

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
            self.attributes[CodingKeys.region.rawValue] = value
        }
    }
    var defenderking: String {
        get {
            return attributes[CodingKeys.defenderking.rawValue] as? String ?? ""
        } set(value) {
            self.attributes[CodingKeys.defenderking.rawValue] = value
        }
    }
    var attackerOutcome: String {
        get {
            return attributes[CodingKeys.attackeroutcome.rawValue] as? String ?? ""
        } set(value) {
            self.attributes[CodingKeys.attackeroutcome.rawValue] = value
        }
    }
    var location: String {
        get {
            return attributes[CodingKeys.location.rawValue] as? String ?? ""
        } set(value) {
            self.attributes[CodingKeys.location.rawValue] = value
        }
    }
    var region: String {
        get {
            return attributes[CodingKeys.region.rawValue] as? String ?? ""
        } set(value) {
            self.attributes[CodingKeys.region.rawValue] = value
        }
    }
    fileprivate var attributes: [AnyHashable: Any?]
    // FIXME: - attackerKing, defenderKing - should be a part of BattleInfo protocol. (todo)
    /*
     Do you really need it here?
    */
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
