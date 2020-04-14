//
//  TestRouterFactory.swift
//  GalleryTests
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

@testable import Gallery

class TestRouterFactory: IRouterFactory {
    
    var editorViewRouter: IEditorViewRouter!
    
    func createEditorViewRouter() -> IEditorViewRouter {
        return editorViewRouter
    }
    
}
