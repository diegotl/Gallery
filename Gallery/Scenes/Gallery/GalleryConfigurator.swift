//
//  GalleryConfigurator.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IGalleryConfigurator {
    func configure(_ viewController: GalleryViewController)
}

struct GalleryConfigurator: IGalleryConfigurator {
    
    func configure(_ viewController: GalleryViewController) {
        let useCaseFactory = UseCaseFactory()
        let routerFactory = RouterFactory(parent: viewController, navigationController: viewController.navigationController)
        viewController.presenter = GalleryPresenter(view: viewController, useCaseFactory: useCaseFactory, routerFactory: routerFactory)
    }
    
}
