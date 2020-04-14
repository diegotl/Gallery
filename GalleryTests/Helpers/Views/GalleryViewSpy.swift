//
//  GalleryViewSpy.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class GalleryViewSpy: IGalleryView {
    
    var currentState: GalleryViewState!
    
    func set(state: GalleryViewState) {
        self.currentState = state
    }
    
}
