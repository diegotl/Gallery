//
//  URLs.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient

enum Endpoints: APIEndpointPath {
    case listImages
    case uploadImage
    
    var value: String {
        switch self {
        case .listImages:
            return "/album/ujvXsTi/images"
        case .uploadImage:
            return "/image"
        }
    }
}
