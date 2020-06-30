//
//  MatchResults.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

struct MatchResults {
    var autobot: Transformer
    var decepticon: Transformer
    var isAutobotWinner: Bool?
}

struct BattleStats {
    var autobotWins: Int
    var decepticonWins: Int
    var survivorsText: String
    var resultTitle: String
}
