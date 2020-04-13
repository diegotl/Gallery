//
//  EditorPresenter.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

protocol IEditorView: class {
    func set(state: EditorViewState)
    func pop()
}

protocol IEditorPresenter {
    var image: LocalImage { get }
    
    func upload()
}

protocol EditorDelegate: class {
    func reloadList()
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
    
    func upload() {
        view?.set(state: .uploading)
        
        uploadImageUseCase.execute(image: image) { result in
            do {
                _ = try result.get()
                self.view?.set(state: .editing)
                self.view?.pop()
                self.delegate?.reloadList()
            } catch {
                //handle error
                print("aa")
            }
        }
    }

}
