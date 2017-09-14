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

class NetworkProcessing {
    let request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
}
