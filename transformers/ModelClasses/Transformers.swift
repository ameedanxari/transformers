//
//  Transformers.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

struct Transformers: Codable {
    var transformers: [Transformer]
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        var array = [[:]]
        for transformer in transformers {
            array.append(transformer.toDictionary())
        }
        dictionary["transformers"] = array
        
        return dictionary
    }
}
