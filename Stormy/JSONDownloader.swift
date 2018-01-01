//
//  JSONDownloader.swift
//  Stormy
//
//  Created by Addison Francisco on 12/30/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import Foundation

// These classes are typically called network manager or network session manager or
// something along those lines but that's not a good idea. Manager in general isn't
// a great name for an object because it's quite vague and the class ends up doing too much,
// particularly because the name isn't very specific about it's responsibilities.
// This class will initiate a network session, but it does so for one purpose only,
// and that is to download the JSON data.

class JSONDownloader {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, DarkSkyError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            // Convert to HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            // Simple error handling
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
}
