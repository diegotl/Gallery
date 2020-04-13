//
//  Adapters.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient
import Foundation

struct AuthAdapter: RequestAdapter {
    
    func adapt(_ request: URLRequest) -> URLRequest {
        var request = request
        request.addValue("Client-ID 7a4d86a35e6a379", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    func complete(request: URLRequest, response: URLResponse?, data: Data?) {}
    
}
