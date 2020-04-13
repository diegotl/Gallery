//
//  Environments.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient

enum Environment: APIEnvionment {
    case production
    
    var baseUrl: String {
        switch self {
            case .production: return "https://api.imgur.com/3"
        }
    }
}
