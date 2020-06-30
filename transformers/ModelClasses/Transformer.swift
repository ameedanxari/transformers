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
    
    init?(id: String, courage: Int, endurance: Int, firepower: Int, intelligence: Int, name: String, rank: Int, skill: Int, speed: Int, strength: Int, team: String, team_icon: String) {
        if team != "A" && team != "D" {
            return nil
        }
        if courage < 1 || courage > 10
        || endurance < 1 || endurance > 10
        || firepower < 1 || firepower > 10
        || intelligence < 1 || intelligence > 10
        || rank < 1 || rank > 10
        || skill < 1 || skill > 10
        || speed < 1 || speed > 10
        || strength < 1 || strength > 10 {
            return nil
        }
        
        self.id = id
        self.name = name
        self.team = team
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        self.team_icon = team_icon
    }
    
    init?(withArray array: [Any]) {
        //Soundwave, D, 8,9,2,6,7,5,6,10
        if array.count != 10{
            return nil
        }
        guard let name = array[0] as? String,
            let team = array[1] as? String else {
            return nil
        }
        if team != "A" && team != "D" {
            return nil
        }
        
        for i in 2..<10 {
            guard let number = array[i] as? Int else {
                return nil
            }
            
            if number < 1 || number > 10 {
                return nil
            }
        }
        
        self.id = ""
        self.name = name
        self.team = team
        self.strength = array[2] as! Int
        self.intelligence = array[3] as! Int
        self.speed = array[4] as! Int
        self.endurance = array[5] as! Int
        self.rank = array[6] as! Int
        self.courage = array[7] as! Int
        self.firepower = array[8] as! Int
        self.skill = array[9] as! Int
        self.team_icon = ""
    }
    
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
