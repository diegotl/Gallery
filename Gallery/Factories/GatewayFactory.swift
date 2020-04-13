//
//  GatewayFactory.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import APIClient

struct GatewayFactory {
    static var api: APIGatewayFactory = APIGatewayFactory()
}

struct APIGatewayFactory {
    
    private var apiClient: APIClient = APIClient(strategy: APIDefaultStrategy(), adapters: [AuthAdapter()])
    
    var image: ImageGateway {
        return APIImageGateway(apiClient: apiClient)
    }
    
}
