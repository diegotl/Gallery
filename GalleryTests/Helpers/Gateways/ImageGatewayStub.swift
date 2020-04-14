//
//  ImageGatewayStub.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class ImageGatewayStub: ImageGateway {
    
    var imagesToReturn: Result<[Image], Error>!
    var imageToReturn: Result<Image, Error>!
    
    func list(completion: @escaping (Result<[Image], Error>) -> Void) {
        completion(imagesToReturn)
    }
    
    func upload(image: LocalImage, completion: @escaping (Result<Image, Error>) -> Void) {
        completion(imageToReturn)
    }
    
}
