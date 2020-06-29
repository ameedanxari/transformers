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
        UserDefaults.standard.set(token, forKey: Global.TOKEN_PREF)
        UserDefaults.standard.synchronize()
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
    
    public func saveTransformers(_ transformers: [Transformer]) {
        let encodedData = try? JSONEncoder().encode(transformers)
        UserDefaults.standard.set(encodedData, forKey: Global.TRANSFORMERS_PREF)
        UserDefaults.standard.synchronize()
    }
    
    public func addTransformer(_ transformer: Transformer) {
        var transformers = getCachedTransformers()
        transformers.append(transformer)
        saveTransformers(transformers)
    }
    
    public func updateTransformer(_ transformer: Transformer) {
        var transformers = getCachedTransformers()
        if let row = transformers.firstIndex(where: {$0.id == transformer.id}) {
               transformers[row] = transformer
        }
        saveTransformers(transformers)
    }
    
    public func getCachedTransformers() -> [Transformer] {
        return (try? JSONDecoder().decode([Transformer].self, from: (UserDefaults.standard.object(forKey: Global.TRANSFORMERS_PREF) as? Data) ?? Data())) ?? []
    }
}
