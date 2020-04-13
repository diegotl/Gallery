//
//  APIImageGateway.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient

struct APIImageGateway: ImageGateway {
    
    let apiClient: APIClient
    
    func list(completion: @escaping (Result<[Image], Error>) -> Void) {
        let request = ListImagesRequest()
        apiClient.execute(apiRequest: request) { (result: Result<APIResponse<[Image]>, APIError>) in
            do {
                let response = try result.get()
                completion(.success(response.data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func upload(image: LocalImage, completion: @escaping (Result<Image, Error>) -> Void) {
        let request = UploadImageRequest(parameter: image)
        apiClient.execute(apiRequest: request) { (result: Result<APIResponse<Image>, APIError>) in
            do {
                let response = try result.get()
                completion(.success(response.data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
