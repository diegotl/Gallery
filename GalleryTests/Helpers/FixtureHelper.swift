//
//  FixtureHelper.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import Foundation
import UIKit

@testable import Gallery

enum TestError: Error {
    case test
}

extension Image: Equatable {
    public static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.link == rhs.link
    }
}

extension LocalImage: Equatable {
    public static func == (lhs: LocalImage, rhs: LocalImage) -> Bool {
        return lhs.image == rhs.image && lhs.album == rhs.album && lhs.angle == rhs.angle
    }
}

extension GalleryViewState: Equatable {
    public static func == (lhs: GalleryViewState, rhs: GalleryViewState) -> Bool {
        switch (lhs, rhs) {
        case (.listing(let lhsImages), .listing(let rhsImages)):
            return lhsImages == rhsImages
            
        case (.loading, .loading):
            return true
            
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
            
        default:
            return false
        }
    }
}

class FixtureHelper {
    
    func getData(from fileName: String, fileExtension: String) throws -> Data {
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: fileName, withExtension: fileExtension) else {
            fatalError()
        }
        
        return try Data(contentsOf: fileURL)
    }
    
    private func createEntity<T: Decodable>(from fileName: String) throws -> T {
        let data = try getData(from: fileName, fileExtension: "json")
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func createImages() -> [Image] {
        return try! createEntity(from: "Images")
    }
    
    func createLocalImage() -> LocalImage {
        return LocalImage(image: UIImage(systemName: "star.fill")!)
    }
    
}

extension Result {
    
    var isSuccess: Bool {
        if case Result.success = self { return true }
        return false
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
}
