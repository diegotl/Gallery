//
//  UseCaseFactory.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IUseCaseFactory {
    func createListImagesUseCase() -> IListImagesUseCase
    func createUploadImageUseCase() -> IUploadImageUseCase
}

struct UseCaseFactory: IUseCaseFactory {
    
    func createListImagesUseCase() -> IListImagesUseCase {
        return ListImagesUseCase(gateway: GatewayFactory.api.image)
    }
    
    func createUploadImageUseCase() -> IUploadImageUseCase {
        return UploadImageUseCase(gateway: GatewayFactory.api.image)
    }
    
}
