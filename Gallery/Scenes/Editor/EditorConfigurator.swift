//
//  EditorConfigurator.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IEditorConfigurator {
    func configure(_ viewController: EditorViewController)
}

struct EditorConfigurator: IEditorConfigurator {
    
    let image: LocalImage
    let delegate: EditorDelegate?
    
    func configure(_ viewController: EditorViewController) {
        let useCaseFactory = UseCaseFactory()
        viewController.presenter = EditorPresenter(view: viewController, useCaseFactory: useCaseFactory, delegate: delegate, image: image)
    }
    
}
