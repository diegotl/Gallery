//
//  ListImagesUseCaseTests.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 14.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import XCTest

@testable import Gallery

class ListImagesUseCaseTests: XCTestCase {
    
    var gateway: ImageGatewayStub!

    override func setUp() {
        gateway = ImageGatewayStub()
    }

    func test_list_images_use_case_success() throws {
        let images = FixtureHelper().createImages()
        gateway.imagesToReturn = .success(images)
        
        let useCase = ListImagesUseCase(gateway: gateway)
        useCase.execute { result in
            do {
                let resultImages = try result.get()
                XCTAssertEqual(images, resultImages.reversed())
            } catch {}
        }
    }
    
    func test_list_images_use_case_failure() throws {
        gateway.imagesToReturn = .failure(TestError.test)
        
        let useCase = ListImagesUseCase(gateway: gateway)
        useCase.execute { result in
            do {
                _ = try result.get()
            } catch {
                XCTAssertEqual(error.localizedDescription, TestError.test.localizedDescription)
            }
        }
    }

}
