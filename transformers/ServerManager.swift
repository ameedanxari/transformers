//
//  ServerManager.swift
//  transformers
//
//  Created by macintosh on 2020-06-28.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import Foundation

//MARK :- API Endpoints
fileprivate struct API
{
    static let BASE_URL           = "https://transformers-api.firebaseapp.com"
    static let TIMEOUT_INTERVAL   = 30.0
    
    static let allSpark           = "/allspark"
    static let transformers       = "/transformers"
}

//MARK :- API Calls
class ServerManager {
    public static let shared = ServerManager()
    
    private func performRequest(method: String,
                               endpoint: String,
                               params: [String: Any]? = nil,
                               completion: @escaping (Error?, URLResponse?, Data?) -> Void ) {
        
        let url = "\(API.BASE_URL)\(endpoint)"
        var request = URLRequest(url: URL(string: url)! , cachePolicy: .useProtocolCachePolicy, timeoutInterval: API.TIMEOUT_INTERVAL)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = method
        if let params = params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        
        if endpoint != API.allSpark {
            if Global.DEBUG {
                print("Headers: \(String(describing: UtilManager.shared.getCachedHeader()))")
            }
            request.allHTTPHeaderFields = UtilManager.shared.getCachedHeader()
        }
        
        if Global.DEBUG {
            print("\(method) Request \(endpoint) with Params \(String(describing: params))")
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if Global.DEBUG {
                print("Response Data: \(String(describing: response))")
            }
            
            completion(error, response, data)
        })
        
        dataTask.resume()
    }
    
    func getAllSparkToken(completion: @escaping (String?, Error?) -> Void) {
        performRequest(method: "GET", endpoint: API.allSpark) { (error, response, data) in
            if response?.getStatusCode() == 200,
                let data = data {
                let token = String(decoding: data, as: UTF8.self)
                completion(token, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getTransformers(completion: @escaping ([Transformer]?, Error?) -> Void) {
        performRequest(method: "GET", endpoint: API.transformers) { (error, response, data) in
            if response?.getStatusCode() == 200,
                let data = data,
                let transformers = try? JSONDecoder().decode(Transformers.self, from: data) {
                completion(transformers.transformers, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func createTransformer(_ transformer: Transformer, completion: @escaping (Transformer?, Error?) -> Void) {
        performRequest(method: "POST",
                       endpoint: API.transformers,
                       params: transformer.toDictionary()) { (error, response, data) in
            if response?.getStatusCode() == 201,
                let data = data,
                let transformer = try? JSONDecoder().decode(Transformer.self, from: data) {
                completion(transformer, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func updateTransformer(_ transformer: Transformer, completion: @escaping (Transformer?, Error?) -> Void) {
        let endpoint = "\(API.transformers)"
        
        performRequest(method: "PUT",
                       endpoint: endpoint,
                       params: transformer.toDictionary()) { (error, response, data) in
            if response?.getStatusCode() == 200,
                let data = data,
                let transformer = try? JSONDecoder().decode(Transformer.self, from: data) {
                completion(transformer, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func deleteTransformer(_ transformer: Transformer, completion: @escaping ([Transformer]?, Error?) -> Void) {
        let endpoint = "\(API.transformers)/\(transformer.id)"
        
        performRequest(method: "DELETE",
                       endpoint: endpoint,
                       params: transformer.toDictionary()) { (error, response, data) in
            if response?.getStatusCode() == 204,
                let data = data,
                let transformers = try? JSONDecoder().decode(Transformers.self, from: data) {
                completion(transformers.transformers, error)
            } else if response?.getStatusCode() == 401 {
                completion(nil, error)
            } else {
                completion(nil, error)
            }
        }
    }
}
