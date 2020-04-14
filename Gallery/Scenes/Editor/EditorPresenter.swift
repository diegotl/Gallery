//
//  EditorPresenter.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IEditorView: class {
    func set(state: EditorViewState)
    func flipImage(newAngle: Float)
    func show(error: Error)
    func pop()
}

protocol IEditorPresenter {
    var image: LocalImage { get }
    
    func rotate()
    func upload()
}

protocol EditorDelegate: class {
    func loadImages()
}

class EditorPresenter: IEditorPresenter {
    
    private weak var view: IEditorView?
    private let useCaseFactory: IUseCaseFactory
    
    private weak var delegate: EditorDelegate?
    let image: LocalImage
    
    lazy private var uploadImageUseCase: IUploadImageUseCase = useCaseFactory.createUploadImageUseCase()
    
    internal init(view: IEditorView? = nil, useCaseFactory: IUseCaseFactory, delegate: EditorDelegate?, image: LocalImage) {
        self.view = view
        self.useCaseFactory = useCaseFactory
        self.delegate = delegate
        self.image = image
    }
    
    func rotate() {
        view?.flipImage(newAngle: image.rotate())
    }
    
    func upload() {
        view?.set(state: .uploading)
        
        uploadImageUseCase.execute(image: image) { result in
            self.view?.set(state: .editing)
            
            do {
                _ = try result.get()
                self.view?.pop()
                self.delegate?.loadImages()
            } catch {
                self.view?.show(error: error)
            }
        }
    }

}
