//
//  Transformer.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

//{
//    "courage":5,
//    "endurance":5,
//    "firepower":5,
//    "id":"-MAyx_zJYh__d9brBWW9",
//    "intelligence":5,
//    "name":"Optimus Prime",
//    "rank":5,
//    "skill":5,
//    "speed":5,
//    "strength":5,
//    "team":"A",
//    "team_icon":"https://tfwiki.net/mediawiki/images2/archive/f/fe/20110410191732%21Symbol_autobot_reg.png"
//}

struct Transformer: Codable {
    var id: String
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
    var team_icon: String
    
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
        dictionary["team_icon"] = team_icon
        
        return dictionary
    }
    
    func getOverallRating() -> Int {
        return strength +
        intelligence +
        speed +
        endurance +
        firepower
    }
}
