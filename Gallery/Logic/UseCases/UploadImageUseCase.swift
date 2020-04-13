//
//  UploadImageUseCase.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IUploadImageUseCase {
    func execute(image: LocalImage, completion: @escaping (_ result: Result<Image, Error>) -> Void)
}

struct UploadImageUseCase: IUploadImageUseCase {

    let gateway: ImageGateway
    
    func execute(image: LocalImage, completion: @escaping (Result<Image, Error>) -> Void) {
        gateway.upload(image: image, completion: completion)
    }

}
