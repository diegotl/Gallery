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
    
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    private var state: EditorViewState = .editing {
        didSet {
            switch state {
            case .editing:
                loadingView.stopAnimating()
                imageView.alpha = 1.0
                rotateButton.isEnabled = true
                uploadButton.isEnabled = true
                
            case .uploading:
                loadingView.startAnimating()
                imageView.alpha = 0.5
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
    
    func flipImage(newAngle: Float) {
        UIView.animate(withDuration: 0.5) {
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(newAngle))
        }
    }
    
    func show(error: Error) {
        let alertController = UIAlertController(title: "Ooops!", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func rotateImage() {
        presenter.rotate()
    }
    
    @IBAction private func uploadImage() {
        presenter.upload()
    }
    
}
