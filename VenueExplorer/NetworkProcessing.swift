//
//  NetworkProcessing.swift
//  VenueExplorer
//
//  Created by Sain-R Edwards Jr. on 9/14/17.
//  Copyright © 2017 Appybuildmore. All rights reserved.
//

import Foundation

// Input: URLRequest (it has a URL)
// Output: returns JSON, or raw data
// Algo: Make a request to server, download the data, return the data

public let DANetworkErrorDomain = "\(Bundle.main.bundleIdentifier!).NetworkingError"
public let MissingHTTPResponseError: Int = 14

class NetworkProcessing {
    let request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
    
    /* The method constructs a URLSession, then download data 
        from the Internet (which takes time). */
    // Returns the data
    // Multithreading
    
    typealias JSON = [String : Any]
    typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void
    
    func downloadJSON(completion: @escaping JSONHandler) {
        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            // Off of the Main Thread
            // Error: missing http response
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: DANetworkErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error as Error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, httpResponse, error)
                }
                
            } else {
                switch httpResponse.statusCode {
                case 200:
                    // OK pasrse JSON into Foundation objects (array, dictionary...)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                        completion(json, httpResponse, nil)
                    } catch let error as NSError {
                        completion(nil, httpResponse, error)
                    }
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
                }
            }
            
        }
        
    }
}




















