//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Addison Francisco on 12/31/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    
    lazy var baseURL: URL = {
        
        // Force unwrap this base URL string so that the app
        // will crash if it cannot be constructed. We cannot do anything
        // without this base URL.
        return URL(string: "https://api.darksky.net/forecast/\(DARK_SKY_API_KEY)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let currentWeatherJSON = json["currently"] as? [String: AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJSON) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                
                completion(currentWeather, nil)
            }
        }
        
        task.resume()
    }
}
