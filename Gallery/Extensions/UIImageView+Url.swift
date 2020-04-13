//
//  UIImageView+Url.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from imageURL: String, loading: @escaping (Bool) -> Void) {
        guard let url = URL(string: imageURL) else {
            image = nil
            return
        }
        
        if let cachedImage = UIImageView.cache.object(forKey: imageURL as NSString) {
            image = cachedImage
        } else {
            loading(true)
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    loading(false)
                    
                    if let data = data, let posterImage = UIImage(data: data) {
                        UIImageView.cache.setObject(posterImage, forKey: imageURL as NSString)
                        self?.image = posterImage
                    }
                }
            }.resume()
        }
        
    }
    
}
