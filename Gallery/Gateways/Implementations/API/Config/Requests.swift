//
//  Requests.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient

final class ListImagesRequest: APIRequest {
    init() {
        let endpoint = APIEndpoint(environment: Environment.production, path: Endpoints.listImages)
        super.init(endpoint: endpoint, method: .get, encoding: .queryString(nil))
    }
}

final class UploadImageRequest: APIRequest {
    init(parameter: Codable) {
        let endpoint = APIEndpoint(environment: Environment.production, path: Endpoints.uploadImage)
        super.init(endpoint: endpoint, method: .post, encoding: .json(parameter))
    }
}
