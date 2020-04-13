//
//  PhotoAccessHelper.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import AVFoundation
import UIKit

enum PhotoAccess: LocalizedError {
    case denied
    case restricted
    
    var localizedDescription: String {
        switch self {
        case .denied:
            return "Please allow camera usage in Settings."
        case .restricted:
            return "You have camera restrictions."
        }
    }
}

class PhotoAccessHelper {
    
    static func requestAccess(handler: @escaping (Result<Bool, PhotoAccess>) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    handler(.success(true))
                } else {
                    handler(.failure(.denied))
                }
            }
            
        case .authorized:
            handler(.success(true))
            
        case .denied:
            handler(.failure(.denied))
            
        case .restricted:
            handler(.failure(.restricted))
            
        @unknown default:
            break
        }
    }
    
}
