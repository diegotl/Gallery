//
//  RouterFactory.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 08.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

protocol IRouterFactory {
    func createEditorViewRouter() -> IEditorViewRouter
}

class RouterFactory: IRouterFactory {
    
    let parent: UIViewController?
    let navigationController: UINavigationController?
    
    internal init(parent: UIViewController? = nil, navigationController: UINavigationController? = nil) {
        self.parent = parent
        self.navigationController = navigationController
    }
    
    func createEditorViewRouter() -> IEditorViewRouter {
        return EditorViewRouter(navigationController: navigationController)
    }
    
}
