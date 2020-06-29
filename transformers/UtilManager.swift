//
//  UtilManager.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

class UtilManager {
public static let shared = UtilManager()
    
    public func saveToken(_ token: String) {
        let userDef = UserDefaults.standard
        userDef.set(token, forKey: Global.TOKEN_PREF)
        userDef.synchronize()
    }
    
    public func getToken() -> String? {
        return UserDefaults.standard.string(forKey: Global.TOKEN_PREF)
    }

    public func getCachedHeader() -> [String:String]? {
        guard let token = getToken() else {
            return nil
        }
        
        return  ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
    }
}
