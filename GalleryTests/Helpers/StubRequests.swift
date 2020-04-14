//
//  StubRequests.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import OHHTTPStubs
import OHHTTPStubsSwift

public func stub(fileName: String, status: Int32 = 200) {
    HTTPStubs.stubRequests(passingTest: { _ in return true }, withStubResponse: { _ -> HTTPStubsResponse in
        let stubPath = OHPathForFile(fileName, FixtureHelper.self)
        return fixture(filePath: stubPath!, status: status, headers: ["Content-Type": "application/json"])
    })
}
