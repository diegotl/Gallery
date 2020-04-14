//
//  GalleryPresenter.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IGalleryView: class {
    func set(state: GalleryViewState)
}

protocol IGalleryPresenter {
    func loadImages()
    func presentEditor(for image: LocalImage)
}

class GalleryPresenter: IGalleryPresenter, EditorDelegate {
    
    private weak var view: IGalleryView?
    private let useCaseFactory: IUseCaseFactory
    private let routerFactory: IRouterFactory
    
    private lazy var listImagesUseCase: IListImagesUseCase = useCaseFactory.createListImagesUseCase()
    private lazy var editorViewRouter: IEditorViewRouter = routerFactory.createEditorViewRouter()
    
    internal init(view: IGalleryView?, useCaseFactory: IUseCaseFactory, routerFactory: IRouterFactory) {
        self.view = view
        self.useCaseFactory = useCaseFactory
        self.routerFactory = routerFactory
    }
    
    func loadImages() {
        view?.set(state: .loading)
        
        listImagesUseCase.execute { result in
            do {
                try self.view?.set(state: .listing(result.get()))
            } catch {
                self.view?.set(state: .failure(error))
            }
        }
    }
    
    func presentEditor(for image: LocalImage) {
        editorViewRouter.navigateTo(with: image, delegate: self)
    }

}
