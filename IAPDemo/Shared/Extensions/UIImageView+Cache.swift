//
//  UIImageView+Cache.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 21/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /**
     Sets the cached image if available or else downloads the image and caches it for subsequent usage.
     */
    func cacheImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let response = data {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        self.image = imageToCache
                    }
                }
            }
        }.resume()
    }
}
