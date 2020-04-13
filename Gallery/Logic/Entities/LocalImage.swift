//
//  LocalImage.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

enum LocalImageError: Error {
    case base64EncodingError
}

class LocalImage: Codable {
    let image: UIImage
    let album: String = "g0MVzI3vYIrxV6q"
    
    enum CodingKeys: String, CodingKey {
        case image
        case album
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    public func encode(to encoder: Encoder) throws {
        guard let base64Data = image.jpegData(compressionQuality: 0.8)?.base64EncodedData(), let base64Image = String(data: base64Data, encoding: .utf8) else {
            throw LocalImageError.base64EncodingError
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(base64Image, forKey: .image)
        try container.encode(album, forKey: .album)
    }
    
    required init(from decoder: Decoder) throws {
        preconditionFailure()
    }
}
