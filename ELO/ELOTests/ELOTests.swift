//
//  ELOTests.swift
//  ELOTests
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import XCTest
@testable import ELO

class ELOTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testJSONObjectsDecode() {
        guard let jsonPath = Bundle.main.url(forResource: "gotjson", withExtension: "json"),
            let data = try? Data.init(contentsOf: jsonPath) else {
            XCTAssert(false, "JSON file not present in the path specified || DATA is nil")
                return
        }
        let decoder = JSONDecoder.init()
        let battles = try? decoder.decode([Battle].self, from: data)
        XCTAssert(nil != battles)
    }
    // MARK: - ELO Calculator
    /*
     Opponent Score: 600
     Factor: 400
     Wins: 2
     Loses: 1
     Number Of games: 3
     Expected: 333.33
     */
    func testELOCalculator() {
        let performanceScore = ELOCalculator.calculate(opponentScore: 600.0, wins: 2, losses: 1)
        // NEEDS PRECISION RESULT HERE. GET RID OF INT type cast and assert to accuracy.
        XCTAssert(Int(performanceScore) == 333, "Score Mataches")
    }
    // FIXME: - DO NOT SHIP THIS FUNCTION `testDummyFunction` TO PRODUCTION
    func testDummyFunction() {
        guard let jsonPath = Bundle.main.url(forResource: "gotjson", withExtension: "json"),
            let data = try? Data.init(contentsOf: jsonPath) else {
                XCTAssert(false, "JSON file not present in the path specified || DATA is nil")
                return
        }
        let decoder = JSONDecoder.init()
        let battles = try? decoder.decode([Battle].self, from: data)
        _ = BattleKingMap.mapKingToBattles(battles!)
        XCTAssert(nil != battles)
    }
    /*
     Adding the count of won + lost ==> Total Number of battles
    */
    func testKingWinLoseAgainstBattleCount() {
        let firstBattleAttributes: [AnyHashable: Any?] = ["name": "Great battle of old time",
                                                          "attacker_king": "GreyJoy",
                                                          "defender_king": "Tyrion",
                                                          "attacker_outcome": "lose",
                                                          "location": "Nalanda",
                                                          "region": "Takshila"]
        let secondBattleAttributes: [AnyHashable: Any?] = ["name": "Great battle of old time",
                                                           "attacker_king": "Tyrion",
                                                           "defender_king": "GreyJoy",
                                                           "attacker_outcome": "win",
                                                           "location": "Nala",
                                                           "region": "Tala"]
        let thirdBattleAttributes: [AnyHashable: Any?] = ["name": "Great battle of old time",
                                                          "attacker_king": "Tyrion",
                                                          "defender_king": "GreyJoy",
                                                          "attacker_outcome": "win",
                                                          "location": "Nala",
                                                          "region": "Tala"]
        let battleOne = Battle.init(attributes: firstBattleAttributes)
        let battleTwo = Battle.init(attributes: secondBattleAttributes)
        let battleThree = Battle.init(attributes: thirdBattleAttributes)
        let battles = [battleOne, battleTwo, battleThree]
        if let kings = BattleKingMap.mapKingToBattles(battles),
            let lastKing = kings.last {
            XCTAssert((lastKing.battlesWon + lastKing.battlesLost) == lastKing.battles.count, "Battle count matches")
        } else {
            XCTAssert(false, "Failed to map kings to battles")
        }
    }
    /*
    Test king object creation
    */
    func testKingCreation() {
        let battleAttributes: [AnyHashable: Any?] = ["name": "Great battle of old time",
                                                          "attacker_king": "GreyJoy",
                                                          "defender_king": "Tyrion",
                                                          "attacker_outcome": "lose",
                                                          "location": "Nalanda",
                                                          "region": "Takshila"]
        let battle = Battle.init(attributes: battleAttributes)
        let king = King.init(name: battle.attackerking)
        XCTAssertEqual(battle.attackerking, king.name)
    }
    
    /*
    Test battle parser
    */
    func testBattleParser() {
        guard let jsonPath = Bundle.main.url(forResource: "gotjson", withExtension: "json"),
            let data = try? Data.init(contentsOf: jsonPath) else {
                XCTAssert(false, "JSON file not present in the path specified || DATA is nil")
                return
        }
        let battles = BattleParser.getBattlesFromData(data)
        XCTAssert((nil != battles && battles!.count > 0), "Parsed battles")
    }
    
    /*
    Test View Model for Kings
    */
    func testViewModelForKings() {
        let kingBattleViewModel = KingBattleViewModel.init()
        kingBattleViewModel.fetchBattleDetails()
        
        let kings = kingBattleViewModel.kings
        
        XCTAssertTrue(kings.count > 0)
    }
}
