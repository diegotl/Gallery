//
//  ImageGateway.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 11.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol ImageGateway {
    func list(completion: @escaping (_ result: Result<[Image], Error>) -> Void)
    func upload(image: LocalImage, completion: @escaping (_ result: Result<Image, Error>) -> Void)
}
