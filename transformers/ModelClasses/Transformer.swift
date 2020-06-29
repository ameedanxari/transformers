//
//  Transformer.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

struct Transformer: Codable {
    var id: Int
    var courage: Int
    var endurance: Int
    var firepower: Int
    var intelligence: Int
    var name: String
    var rank: Int
    var skill: Int
    var speed: Int
    var strength: Int
    var team: String
    var teamIcon: String
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        dictionary["id"] = id
        dictionary["courage"] = courage
        dictionary["endurance"] = endurance
        dictionary["firepower"] = firepower
        dictionary["intelligence"] = intelligence
        dictionary["name"] = name
        dictionary["rank"] = rank
        dictionary["skill"] = skill
        dictionary["speed"] = speed
        dictionary["strength"] = strength
        dictionary["team"] = team
        dictionary["team_icon"] = teamIcon
        
        return dictionary
    }
}
