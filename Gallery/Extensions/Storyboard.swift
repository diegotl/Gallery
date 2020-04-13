//
//  Storyboard.swift
//  Gallery
//
//  Created by Diego Trevisan Lara on 13.04.20.
//  Copyright © 2020 Diego Trevisan Lara. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

extension Storyboard {
    
    func instantiate<T>(_ viewClass: T.Type) -> T {
        return instantiate(String(describing: viewClass), type: T.self)
    }
    
    func instantiate<T>(_ identifier: String, type: T.Type) -> T {
        // swiftlint:disable force_cast
        return UIStoryboard(name: rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as! T
        // swiftlint:enable force_cast
    }
    
}
