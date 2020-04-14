//
//  GalleryViewController.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

enum GalleryViewState {
    case loading
    case listing([Image])
    case failure(Error)
}

class GalleryViewController: UICollectionViewController, IGalleryView {
    
    var configurator: IGalleryConfigurator! = GalleryConfigurator()
    var presenter: IGalleryPresenter!
    
    private let refreshControl = UIRefreshControl()
    
    private var state: GalleryViewState = .loading {
        didSet {
            switch state {
            case .loading:
                let spinnerView = UIActivityIndicatorView(style: .medium)
                spinnerView.startAnimating()
                collectionView.backgroundView = spinnerView
                
            case .listing:
                refreshControl.endRefreshing()
                collectionView.backgroundView = nil
                
            case .failure(let error):
                refreshControl.endRefreshing()
                let errorLabel = UILabel()
                errorLabel.text = error.localizedDescription
                errorLabel.textAlignment = .center
                collectionView.backgroundView = errorLabel
            }
            
            collectionView.reloadData()
        }
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        
        setupUI()
        presenter.loadImages()
    }
    
    private func setupUI() {
        title = "Gallery"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(uploadPhoto))
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadList), for: .valueChanged)
    }
    
    // MARK: - IGalleryView
    
    func set(state: GalleryViewState) {
        self.state = state
    }
    
    // MARK: - Actions
    
    private func show(errorMessage: String) {
        let alertController = UIAlertController(title: "Ooops!", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @objc private func reloadList() {
        presenter.loadImages()
    }
    
    @objc private func uploadPhoto() {
        let actionSheet = UIAlertController(title: "Upload Photo", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "From Camera", style: .default, handler: { _ in
            self.presentPicker(for: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "From Photo Library", style: .default, handler: { _ in
            self.presentPicker(for: .photoLibrary)
        }))
        
        actionSheet.addAction(.init(title: "Cancel", style: .destructive, handler: nil))
        present(actionSheet, animated: true)
    }
    
    private func presentPicker(for sourceType: UIImagePickerController.SourceType) {
        PhotoAccessHelper.requestAccess { result in
            DispatchQueue.main.async {
                do {
                    _ = try result.get()
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = sourceType
                    imagePicker.allowsEditing = true
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true)
                    
                } catch {
                    self.show(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard case GalleryViewState.listing(let images) = state else { return 0 }
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if case GalleryViewState.listing(let images) = state {
            cell.image = images[indexPath.row]
        }
        
        return cell
    }
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - (6 * 8)
        return CGSize(width: screenWidth/3, height: screenWidth/3)
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            show(errorMessage: "Error obtaining image.")
            return
        }
        
        picker.dismiss(animated: true) {
            self.presenter.presentEditor(for: LocalImage(image: image))
        }
    }
    
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var image: Image? {
        didSet {
            guard let image = image else {
                imageView.image = nil
                return
            }
            
            imageView.loadImage(from: image.link) { loading in
                
            }
        }
    }
    
}
