//
//  Global.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

struct Global {
    static let DEBUG = true
    
    static let TOKEN_PREF = "token"
    static let TRANSFORMERS_PREF = "transformers"
    
    static let TRANSFORMERS_CHANGED = NSNotification.Name(rawValue: "transformers_changed")
    
    static let AUTOBOT_COLOR = #colorLiteral(red: 0.8028171062, green: 0.9826404452, blue: 0.8881685138, alpha: 1)
    static let DECEPTICON_COLOR = #colorLiteral(red: 0.9884110093, green: 0.8029901385, blue: 0.8095681071, alpha: 1)
}
