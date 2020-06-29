//
//  MatchResults.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

struct MatchResults {
    var op1: Transformer
    var op2: Transformer
    var status: String
    var winner: Transformer?
    var tied: Bool = false
}
