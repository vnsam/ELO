//
//  Constants.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

struct Constants {
}

// MARK: - Network
extension Constants {
    struct Network {
        static let baseURL = "http://starlord.hackerearth.com/"
        struct Endpoint {
            static let battleInfo = "gotjson"
        }
    }
}

// MARK: - Battle
extension Constants {
    //https://stackoverflow.com/a/46767132/2776045 - I keep getting nested type viloation from SwiftLint - Discuss
    struct Battle {
    struct AttackerOutcome {
            static let win = "win"
        }
    }
}

// MARK: - Score
extension Constants {
    struct ELO {
        static let initalRating: Double = 1000.0
        static let factor: Double = 400.0
    }
}
