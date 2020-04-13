//
//  EditorViewController.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

enum EditorViewState {
    case editing
    case uploading
}

class EditorViewController: UIViewController, IEditorView {
    
    var configurator: IEditorConfigurator!
    var presenter: IEditorPresenter!
    
    private var state: EditorViewState = .editing {
        didSet {
            switch state {
            case .editing:
                imageView.alpha = 1.0
                rotateButton.isEnabled = true
                uploadButton.isEnabled = true
                
            case .uploading:
                imageView.alpha = 0.7
                rotateButton.isEnabled = false
                uploadButton.isEnabled = false
            }
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var rotateButton: UIButton!
    @IBOutlet private weak var uploadButton: UIButton!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        
        setupUI()
    }
    
    private func setupUI() {
        imageView.image = presenter.image.image
    }
    
    // MARK: - IEditorView
    
    func set(state: EditorViewState) {
        self.state = state
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func rotateImage() {
        
    }
    
    @IBAction private func uploadImage() {
        presenter.upload()
    }
    
}
