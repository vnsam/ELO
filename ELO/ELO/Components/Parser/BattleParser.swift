//
//  BattleParser.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class BattleParser {
    class func getBattlesFromData(_ data: Data) -> [Battle]? {
        do {
            let battles =  try CustomJSONDecoder.jsonDecoder.decode([Battle].self, from: data)
            return battles
        } catch {
            debugPrint("Error parsing Battles from Data: \(error.localizedDescription) @ \(#function, #line)")
        }
        return nil
    }
}
