//
//  EditorViewRouter.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

protocol IEditorViewRouter {
    func navigateTo(with image: LocalImage, delegate: EditorDelegate?)
}

struct EditorViewRouter: IEditorViewRouter {
    
    private(set) weak var navigationController: UINavigationController?

    func navigateTo(with image: LocalImage, delegate: EditorDelegate?) {
        let view = Storyboard.main.instantiate(EditorViewController.self)
        view.configurator = EditorConfigurator(image: image, delegate: delegate)
        navigationController?.pushViewController(view, animated: true)
    }

}
