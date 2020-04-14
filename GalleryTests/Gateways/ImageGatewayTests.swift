//
//  ImageGatewayTests.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import XCTest
import APIClient

@testable import Gallery

class ImageGatewayTests: XCTestCase {
    
    let apiClient = APIClient(strategy: APIImgurStrategy(), adapters: [])

    func test_list_images_success() throws {
        stub(fileName: "ListImageSuccess.json")
        let gateway = APIImageGateway(apiClient: apiClient)
        
        let requestExpectation = expectation(description: "Success")
        
        gateway.list { result in
            XCTAssertTrue(result.isSuccess)
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
    }
    
    func test_list_images_failure() throws {
        stub(fileName: "Error.json")
        let gateway = APIImageGateway(apiClient: apiClient)
        
        let requestExpectation = expectation(description: "Failure")
        
        gateway.list { result in
            do {
                _ = try result.get()
            } catch {
                XCTAssertEqual(error.localizedDescription, "This is a test error message")
                requestExpectation.fulfill()
            }
        }
        
        wait(for: [requestExpectation], timeout: 1)
    }

}
