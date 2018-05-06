//
//  KingDetailParser.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class KingDetailParser {
    class func getDetails(for king: King) -> [AnyHashable: Any] {
        var attributes: [AnyHashable: Any] = [:]
        attributes[Constants.KingDetail.name] = king.name
        let battles = king.battles.map { $0.name }
        attributes[Constants.KingDetail.battles] = battles
        return attributes
    }
}
