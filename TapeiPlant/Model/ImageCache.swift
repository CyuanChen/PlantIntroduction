//
//  ImageCache.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/11.
//

import Foundation
import UIKit
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
