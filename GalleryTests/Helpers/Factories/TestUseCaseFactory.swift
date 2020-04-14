//
//  TestUseCaseFactory.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class TestUseCaseFactory: IUseCaseFactory {
    
    var listImagesUseCase: IListImagesUseCase!
    var uploadImageUseCase: IUploadImageUseCase!
    
    func createListImagesUseCase() -> IListImagesUseCase {
        return listImagesUseCase
    }
    
    func createUploadImageUseCase() -> IUploadImageUseCase {
        return uploadImageUseCase
    }
    
}
