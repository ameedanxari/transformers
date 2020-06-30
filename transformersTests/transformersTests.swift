//
//  transformersTests.swift
//  transformersTests
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import XCTest
@testable import transformers

class transformersTests: XCTestCase {
    let expectationTimeout = 10.0
    var transformers: [Transformer] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        transformers = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Test Server calls
    func testGetAllSpark() throws {
        let exp = expectation(description: "spark token api response")
        
        ServerManager.shared.getAllSparkToken { (token, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(token)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: expectationTimeout)
    }
    
    func testTransformersCRUD() throws {
        let expAllSpark = expectation(description: "spark token api response")
        ServerManager.shared.getAllSparkToken { (token, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(token)
            UtilManager.shared.saveToken(token!)
            expAllSpark.fulfill()
        }
        wait(for: [expAllSpark], timeout: expectationTimeout)
        
        let expEmptyAllTransformers = expectation(description: "all transformers empty initially")
        ServerManager.shared.getTransformers { (transformers, error) in
            XCTAssertNil(error)
            XCTAssertEqual(transformers?.count, 0)
            expEmptyAllTransformers.fulfill()
        }
        wait(for: [expEmptyAllTransformers], timeout: expectationTimeout)
        
        let expCreateTransformer1 = expectation(description: "create transformer success")
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 8,9,2,6,7,5,6,10])
        ServerManager.shared.createTransformer(transformer1!) { (transformer, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformer)
            
            XCTAssertNotEqual(transformer1?.id, transformer?.id)
            XCTAssertFalse(transformer!.id.isEmpty)
            XCTAssertEqual(transformer1?.name, transformer?.name)
            XCTAssertEqual(transformer1?.strength, transformer?.strength)
            XCTAssertEqual(transformer1?.intelligence, transformer?.intelligence)
            XCTAssertEqual(transformer1?.speed, transformer?.speed)
            XCTAssertEqual(transformer1?.endurance, transformer?.endurance)
            XCTAssertEqual(transformer1?.rank, transformer?.rank)
            XCTAssertEqual(transformer1?.courage, transformer?.courage)
            XCTAssertEqual(transformer1?.firepower, transformer?.firepower)
            XCTAssertEqual(transformer1?.skill, transformer?.skill)
            XCTAssertEqual(transformer1?.team, transformer?.team)
            XCTAssertNotEqual(transformer1?.team_icon, transformer?.team_icon)
            XCTAssertFalse(transformer!.team_icon.isEmpty)
            
            expCreateTransformer1.fulfill()
        }
        wait(for: [expCreateTransformer1], timeout: expectationTimeout)
        
        let expOneAllTransformers = expectation(description: "one transformer created")
        ServerManager.shared.getTransformers { (transformers, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformers)
            XCTAssertEqual(transformers?.count, 1)
            expOneAllTransformers.fulfill()
        }
        wait(for: [expOneAllTransformers], timeout: expectationTimeout)
        
        let expCreateTransformer2 = expectation(description: "create transformer success")
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        ServerManager.shared.createTransformer(transformer2!) { (transformer, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformer)
            
            XCTAssertNotEqual(transformer2?.id, transformer?.id)
            XCTAssertFalse(transformer!.id.isEmpty)
            XCTAssertEqual(transformer2?.name, transformer?.name)
            XCTAssertEqual(transformer2?.strength, transformer?.strength)
            XCTAssertEqual(transformer2?.intelligence, transformer?.intelligence)
            XCTAssertEqual(transformer2?.speed, transformer?.speed)
            XCTAssertEqual(transformer2?.endurance, transformer?.endurance)
            XCTAssertEqual(transformer2?.rank, transformer?.rank)
            XCTAssertEqual(transformer2?.courage, transformer?.courage)
            XCTAssertEqual(transformer2?.firepower, transformer?.firepower)
            XCTAssertEqual(transformer2?.skill, transformer?.skill)
            XCTAssertEqual(transformer2?.team, transformer?.team)
            XCTAssertNotEqual(transformer2?.team_icon, transformer?.team_icon)
            XCTAssertFalse(transformer!.team_icon.isEmpty)
            
            expCreateTransformer2.fulfill()
        }
        wait(for: [expCreateTransformer2], timeout: expectationTimeout)
        
        let expTwoAllTransformers = expectation(description: "two transformers created")
        ServerManager.shared.getTransformers { (transformers, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformers)
            XCTAssertEqual(transformers?.count, 2)
            self.transformers = transformers!
            expTwoAllTransformers.fulfill()
        }
        wait(for: [expTwoAllTransformers], timeout: expectationTimeout)
        
        let expUpdateInvalidTransformer = expectation(description: "update invalid transformer")
        ServerManager.shared.updateTransformer(transformer1!) { (transformer, error) in
            XCTAssertNil(error)
            XCTAssertNil(transformer)
            expUpdateInvalidTransformer.fulfill()
        }
        wait(for: [expUpdateInvalidTransformer], timeout: expectationTimeout)
        
        let expUpdateValidTransformer = expectation(description: "update valid transformer")
        self.transformers[0].name = "Optimus Prime"
        self.transformers[0].strength = 1
        self.transformers[0].intelligence = 2
        self.transformers[0].speed = 3
        self.transformers[0].endurance = 4
        self.transformers[0].rank = 5
        self.transformers[0].courage = 6
        self.transformers[0].firepower = 7
        self.transformers[0].skill = 8
        self.transformers[0].team = "A"
        ServerManager.shared.updateTransformer(self.transformers[0]) { (transformer, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformer)
            XCTAssertEqual(self.transformers[0].id, transformer?.id)
            XCTAssertFalse(transformer!.id.isEmpty)
            XCTAssertEqual(self.transformers[0].name, transformer?.name)
            XCTAssertEqual(self.transformers[0].strength, transformer?.strength)
            XCTAssertEqual(self.transformers[0].intelligence, transformer?.intelligence)
            XCTAssertEqual(self.transformers[0].speed, transformer?.speed)
            XCTAssertEqual(self.transformers[0].endurance, transformer?.endurance)
            XCTAssertEqual(self.transformers[0].rank, transformer?.rank)
            XCTAssertEqual(self.transformers[0].courage, transformer?.courage)
            XCTAssertEqual(self.transformers[0].firepower, transformer?.firepower)
            XCTAssertEqual(self.transformers[0].skill, transformer?.skill)
            XCTAssertEqual(self.transformers[0].team, transformer?.team)
            XCTAssertNotEqual(self.transformers[0].team_icon, transformer?.team_icon)
            XCTAssertFalse(transformer!.team_icon.isEmpty)
            expUpdateValidTransformer.fulfill()
        }
        wait(for: [expUpdateValidTransformer], timeout: expectationTimeout)
        
        let expDeleteValidTransformer = expectation(description: "delete valid transformer")
        ServerManager.shared.deleteTransformer(self.transformers[0]) { (transformers, error) in
            XCTAssertNil(error)
            //failing, but as per documentation, delete success API returns list of remaining transformers
            XCTAssertNotNil(transformers)
            XCTAssertEqual(transformers?.count, 1)
            expDeleteValidTransformer.fulfill()
        }
        wait(for: [expDeleteValidTransformer], timeout: expectationTimeout)
        
        let expDeleteInvalidTransformer = expectation(description: "delete invalid transformer")
        ServerManager.shared.deleteTransformer(transformer1!) { (transformers, error) in
            XCTAssertNil(error)
            XCTAssertNil(transformers)
            expDeleteInvalidTransformer.fulfill()
        }
        wait(for: [expDeleteInvalidTransformer], timeout: expectationTimeout)
        
        let expOneTransformerLeft = expectation(description: "one transformer left")
        ServerManager.shared.getTransformers { (transformers, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(transformers)
            XCTAssertEqual(transformers?.count, 1)
            expOneTransformerLeft.fulfill()
        }
        wait(for: [expOneTransformerLeft], timeout: expectationTimeout)
    }
    
    //MARK: - Test UtilManager
    func testAllSparkUserDefaults() throws {
        let token = "some_token_value"
        UtilManager.shared.saveToken(token)
        XCTAssertEqual(UtilManager.shared.getToken(), token)
    }
    
    func testCachedHeader() throws {
        XCTAssertNil(UtilManager.shared.getCachedHeader())
        
        let token = "some_token_value"
        let header = ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
        UtilManager.shared.saveToken(token)
        XCTAssertNotNil(UtilManager.shared.getCachedHeader())
        XCTAssertEqual(UtilManager.shared.getCachedHeader(), header)
    }
    
    func testTransformersUserDefaults() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 8,9,2,6,7,5,6,10])
        XCTAssertNotNil(transformer1)
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        XCTAssertNotNil(transformer2)
        
        transformers.append(transformer1!)
        UtilManager.shared.saveTransformers(transformers)
        var cachedTransformers = UtilManager.shared.getCachedTransformers()
        XCTAssertEqual(cachedTransformers.count, 1)
        XCTAssertEqual(cachedTransformers[0].name, transformer1?.name)
        
        UtilManager.shared.updateTransformer(transformer2!)
        cachedTransformers = UtilManager.shared.getCachedTransformers()
        XCTAssertEqual(cachedTransformers.count, 1)
        XCTAssertEqual(cachedTransformers[0].name, transformer2?.name)
        
        transformers.append(transformer2!)
        UtilManager.shared.saveTransformers(transformers)
        cachedTransformers = UtilManager.shared.getCachedTransformers()
        XCTAssertEqual(cachedTransformers.count, 2)
        XCTAssertNotEqual(cachedTransformers[0].name, cachedTransformers[1].name)
        XCTAssertNotEqual(cachedTransformers[0].team, cachedTransformers[1].team)
    }
    
    //MARK: - Test Transformer DataModel
    func testInvalidArrayInit() throws {
        XCTAssertNil(Transformer(withArray: [1,1,1,1,1,1,1,1,"OPTIMUS PRIME","D"]))
        XCTAssertNil(Transformer(withArray: ["OPTIMUS PRIME","D",1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]))
        XCTAssertNil(Transformer(withArray: ["OPTIMUS PRIME", "D", 0,1,1,1,1,1,1,1]))
        XCTAssertNil(Transformer(withArray: ["OPTIMUS PRIME", "F", 1,1,1,1,1,1,1,1]))
        XCTAssertNil(Transformer(withArray: ["OPTIMUS PRIME", "A", 1,1,1,1,1,1,1,15]))
    }

    func testTransformerOverallRating() throws {
        let transformer1 = Transformer(withArray: ["optimus prime", "A", 10,10,10,10,10,10,10,10])
        let transformer2 = Transformer(withArray: ["PREDAKING", "D", 1,1,1,1,1,1,1,1])
        let transformer3 = Transformer(withArray: ["Soundwave", "D", 8,9,2,6,7,5,6,10])
        let transformer4 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        XCTAssertEqual(transformer1?.getOverallRating(), 50)
        XCTAssertEqual(transformer2?.getOverallRating(), 5)
        XCTAssertEqual(transformer3?.getOverallRating(), 31)
        XCTAssertEqual(transformer4?.getOverallRating(), 37)
    }
    
    //MARK: - Test Battle Ground
    func testNoTransformersFight() throws {
        let fightRing = FightRingVC()
        fightRing.transformers = []
        let stats = fightRing.getFightResults()
        
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "NO OPPONENTS")
        XCTAssertEqual(stats.survivorsText, "Autobot Survivors: \nDecepticon Survivors: ")
    }
    
    func testAllSameTransformersFight() throws {
        let transformer1 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        let transformer2 = Transformer(withArray: ["Hubcap", "A", 4,4,4,4,4,4,4,4])
        let transformer3 = Transformer(withArray: ["Optimus Prime", "A", 1,1,1,1,1,1,1,1])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer3!, transformer2!, transformer1!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "NO OPPONENTS")
        XCTAssertEqual(stats.survivorsText, "Autobot Survivors: Bluestreak, Hubcap, Optimus Prime\nDecepticon Survivors: ")
        
        let transformer4 = Transformer(withArray: ["Bluestreak", "D", 6,6,7,9,5,2,9,7])
        let transformer5 = Transformer(withArray: ["Hubcap", "D", 4,4,4,4,4,4,4,4])
        let transformer6 = Transformer(withArray: ["Optimus Prime", "D", 1,1,1,1,1,1,1,1])
        XCTAssertNotNil(transformer4)
        XCTAssertNotNil(transformer5)
        XCTAssertNotNil(transformer6)
        
        fightRing.transformers = [transformer4!, transformer5!, transformer6!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "NO OPPONENTS")
        XCTAssertEqual(stats.survivorsText, "Autobot Survivors: \nDecepticon Survivors: Bluestreak, Hubcap, Optimus Prime")
    }

    func testOptimusPrimePredakingFight() throws {
        let opD = Transformer(withArray: ["OPTIMUS PRIME", "D", 1,1,1,1,1,1,1,1])
        let opA = Transformer(withArray: ["optimus prime", "A", 10,10,10,10,10,10,10,10])
        let pkD = Transformer(withArray: ["PREDAKING", "D", 10,10,10,10,10,10,10,10])
        let pkA = Transformer(withArray: ["predaking", "A", 1,1,1,1,1,1,1,1])
        XCTAssertNotNil(opD)
        XCTAssertNotNil(opA)
        XCTAssertNotNil(pkD)
        XCTAssertNotNil(pkA)
        
        let fightRing = FightRingVC()
        
        fightRing.transformers = [opD!, opA!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "TOTAL ANNIHILATION")
        XCTAssertEqual(stats.survivorsText, "No survivors...")
        
        fightRing.transformers = [pkA!, pkD!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "TOTAL ANNIHILATION")
        XCTAssertEqual(stats.survivorsText, "No survivors...")
        
        fightRing.transformers = [opA!, pkD!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "TOTAL ANNIHILATION")
        XCTAssertEqual(stats.survivorsText, "No survivors...")
        
        fightRing.transformers = [pkA!, pkD!, opD!, opA!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "TOTAL ANNIHILATION")
        XCTAssertEqual(stats.survivorsText, "No survivors...")
    }
    
    func testCourageStrengthFight() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 7,10,10,10,10,6,10,10])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 10,1,1,1,1,10,1,1])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer1!, transformer2!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 1)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "AUTOBOTS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Autobots): Bluestreak\nSurvivors from the losing team (Decepticons): ")
        
        let transformer3 = Transformer(withArray: ["Soundwave", "A", 1,10,10,10,10,1,10,10])
        let transformer4 = Transformer(withArray: ["Bluestreak", "D", 4,1,1,1,1,5,1,1])
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        fightRing.transformers = [transformer3!, transformer4!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 1)
        XCTAssertEqual(stats.resultTitle, "DECEPTICONS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Decepticons): Bluestreak\nSurvivors from the losing team (Autobots): ")
    }
    
    func testSkillFight() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 1,10,10,10,10,1,10,7])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 1,1,1,1,1,1,1,10])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer1!, transformer2!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 1)
        XCTAssertEqual(stats.decepticonWins, 0)
        print(stats.resultTitle)
        print(stats.survivorsText)
        XCTAssertEqual(stats.resultTitle, "AUTOBOTS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Autobots): Bluestreak\nSurvivors from the losing team (Decepticons): ")
        
        let transformer3 = Transformer(withArray: ["Soundwave", "A", 1,10,10,10,10,1,10,1])
        let transformer4 = Transformer(withArray: ["Bluestreak", "D", 1,1,1,1,1,1,1,4])
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        fightRing.transformers = [transformer3!, transformer4!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 1)
        print(stats.resultTitle)
        print(stats.survivorsText)
        XCTAssertEqual(stats.resultTitle, "DECEPTICONS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Decepticons): Bluestreak\nSurvivors from the losing team (Autobots): ")
    }
    
    func testExtraOpponentFight() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 8,9,2,6,7,5,6,10])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        let transformer3 = Transformer(withArray: ["Hubcap", "A", 4,4,4,4,4,4,4,4])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer3!, transformer2!, transformer1!]
        let stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 1)
        XCTAssertEqual(stats.resultTitle, "DECEPTICONS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Decepticons): Soundwave\nSurvivors from the losing team (Autobots): Hubcap")
    }
    
    func testOptimusPrimePredakingAsExtraFight() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 8,9,2,6,7,5,6,10])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 6,6,7,9,5,2,9,7])
        let transformer3 = Transformer(withArray: ["Hubcap", "A", 4,4,4,4,4,4,4,4])
        let transformer4 = Transformer(withArray: ["Optimus Prime", "A", 1,1,1,1,1,1,1,1])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer4!, transformer3!, transformer2!, transformer1!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 1)
        XCTAssertEqual(stats.resultTitle, "DECEPTICONS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Decepticons): Soundwave\nSurvivors from the losing team (Autobots): Hubcap, Optimus Prime")
        
        let transformer5 = Transformer(withArray: ["Soundwave", "A", 8,9,2,6,7,5,6,10])
        let transformer6 = Transformer(withArray: ["Bluestreak", "D", 6,6,7,9,5,2,9,7])
        let transformer7 = Transformer(withArray: ["Hubcap", "D", 4,4,4,4,4,4,4,4])
        let transformer8 = Transformer(withArray: ["Predaking", "D", 1,1,1,1,1,1,1,1])
        XCTAssertNotNil(transformer5)
        XCTAssertNotNil(transformer6)
        XCTAssertNotNil(transformer7)
        XCTAssertNotNil(transformer8)
        
        fightRing.transformers = [transformer5!, transformer6!, transformer7!, transformer8!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 1)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "AUTOBOTS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Autobots): Soundwave\nSurvivors from the losing team (Decepticons): Hubcap, Predaking")
    }
    
    func testOptimusPrimePredakingWinFight() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 10,10,10,10,10,10,10,10])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 1,1,1,1,1,1,1,1])
        let transformer3 = Transformer(withArray: ["Hubcap", "A", 1,1,1,1,1,1,1,1])
        let transformer4 = Transformer(withArray: ["Optimus Prime", "A", 2,2,2,2,2,2,2,2])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer4!, transformer3!, transformer2!, transformer1!]
        var stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 1)
        XCTAssertEqual(stats.decepticonWins, 0)
        XCTAssertEqual(stats.resultTitle, "AUTOBOTS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Autobots): Optimus Prime, Hubcap, Bluestreak\nSurvivors from the losing team (Decepticons): ")
        
        let transformer5 = Transformer(withArray: ["Soundwave", "A", 10,10,10,10,10,10,10,10])
        let transformer6 = Transformer(withArray: ["Bluestreak", "D", 1,1,1,1,1,1,1,1])
        let transformer7 = Transformer(withArray: ["Hubcap", "D", 1,1,1,1,1,1,1,1])
        let transformer8 = Transformer(withArray: ["Predaking", "D", 2,2,2,2,2,2,2,2])
        XCTAssertNotNil(transformer5)
        XCTAssertNotNil(transformer6)
        XCTAssertNotNil(transformer7)
        XCTAssertNotNil(transformer8)
        
        fightRing.transformers = [transformer5!, transformer6!, transformer7!, transformer8!]
        stats = fightRing.getFightResults()
        XCTAssertEqual(stats.autobotWins, 0)
        XCTAssertEqual(stats.decepticonWins, 1)
        XCTAssertEqual(stats.resultTitle, "DECEPTICONS WIN!")
        XCTAssertEqual(stats.survivorsText, "Winning team (Decepticons): Predaking, Bluestreak, Hubcap\nSurvivors from the losing team (Autobots): ")
    }
    
    func testMaxFightCount() throws {
        let transformer1 = Transformer(withArray: ["Soundwave", "D", 10,10,10,10,10,10,10,10])
        let transformer2 = Transformer(withArray: ["Bluestreak", "A", 1,1,1,1,1,1,1,1])
        let transformer3 = Transformer(withArray: ["Hubcap", "A", 1,1,1,1,1,1,1,1])
        let transformer4 = Transformer(withArray: ["Optimus Prime", "A", 2,2,2,2,2,2,2,2])
        XCTAssertNotNil(transformer1)
        XCTAssertNotNil(transformer2)
        XCTAssertNotNil(transformer3)
        XCTAssertNotNil(transformer4)
        
        let fightRing = FightRingVC()
        fightRing.transformers = [transformer4!, transformer3!, transformer2!, transformer1!]
        XCTAssertEqual(fightRing.getMaxFightCount(), 1)
        
        let transformer5 = Transformer(withArray: ["Soundwave", "A", 10,10,10,10,10,10,10,10])
        let transformer6 = Transformer(withArray: ["Bluestreak", "A", 1,1,1,1,1,1,1,1])
        let transformer7 = Transformer(withArray: ["Hubcap", "D", 1,1,1,1,1,1,1,1])
        let transformer8 = Transformer(withArray: ["Predaking", "D", 2,2,2,2,2,2,2,2])
        XCTAssertNotNil(transformer5)
        XCTAssertNotNil(transformer6)
        XCTAssertNotNil(transformer7)
        XCTAssertNotNil(transformer8)
        
        fightRing.transformers = [transformer5!, transformer6!, transformer7!, transformer8!]
        XCTAssertEqual(fightRing.getMaxFightCount(), 2)
        
        let transformer9 = Transformer(withArray: ["Soundwave", "A", 10,10,10,10,10,10,10,10])
        let transformer10 = Transformer(withArray: ["Bluestreak", "D", 1,1,1,1,1,1,1,1])
        let transformer11 = Transformer(withArray: ["Hubcap", "D", 1,1,1,1,1,1,1,1])
        let transformer12 = Transformer(withArray: ["Optimus Prime", "D", 2,2,2,2,2,2,2,2])
        XCTAssertNotNil(transformer9)
        XCTAssertNotNil(transformer10)
        XCTAssertNotNil(transformer11)
        XCTAssertNotNil(transformer12)
        
        fightRing.transformers = [transformer9!, transformer10!, transformer11!, transformer12!]
        XCTAssertEqual(fightRing.getMaxFightCount(), 1)
    }
}
