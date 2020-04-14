//
//  EditorViewRouterSpy.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 14.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class EditorViewRouterSpy: IEditorViewRouter {
    
    var imageToEdit: LocalImage!
    
    func navigateTo(with image: LocalImage, delegate: EditorDelegate?) {
        self.imageToEdit = image
    }
    
}
