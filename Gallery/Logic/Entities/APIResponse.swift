//
//  APIResponse.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

class APIResponse<T: Codable>: Codable {
    let data: T
    let success: Bool
    let status: Int
}
