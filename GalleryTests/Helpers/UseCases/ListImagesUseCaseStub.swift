//
//  ListImagesUseCaseStub.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class ListImagesUseCaseStub: IListImagesUseCase {
    
    var resultToBeReturned: Result<[Image], Error>!
    
    func execute(completion: @escaping (Result<[Image], Error>) -> Void) {
        completion(resultToBeReturned)
    }
    
}
