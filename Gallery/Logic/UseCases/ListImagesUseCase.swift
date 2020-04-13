//
//  ListImagesUseCase.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IListImagesUseCase {
    func execute(completion: @escaping (_ result: Result<[Image], Error>) -> Void)
}

struct ListImagesUseCase: IListImagesUseCase {

    let gateway: ImageGateway
    
    func execute(completion: @escaping (Result<[Image], Error>) -> Void) {
        gateway.list { result in
            do {
                try completion(.success(result.get().reversed()))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
