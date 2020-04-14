//
//  Strategy.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient
import Foundation

enum ImgurError: LocalizedError {
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .message(let message):
            return message
        }
    }
}

public struct APIImgurStrategy: APIStrategy {
    
    public init() {}
    
    public func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        if let error = error {
            DispatchQueue.main.async { completion(.failure(.underlying(error))) }
        } else {
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async { completion(.success(object)) }
            } catch {
                do {
                    let object = try JSONDecoder().decode(APIResponse<ErrorResponse>.self, from: data!)
                    let imgurError = ImgurError.message(object.data.error)
                    DispatchQueue.main.async { completion(.failure(.underlying(imgurError))) }
                    
                } catch {
                    let result: Result<T, APIError> = .failure(.underlying(error))
                    DispatchQueue.main.async { completion(result) }
                }
            }
            
        }
        
    }
    
}

