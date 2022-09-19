//
//  UIImageView+ImageLoader.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadImage(from url: String?,
                       placeholderImage: UIImage?) {

        self.image = nil
        sd_cancelCurrentImageLoad()
        guard let originalUrlString = url else {
            image = placeholderImage
            return
        }

        if let transformedUrl = URL(string: originalUrlString) {

            if let image = SDImageCache.shared.imageFromDiskCache(forKey: transformedUrl.absoluteString) {
                self.image = image
                return
            }
            self.sd_setImage(with: transformedUrl, placeholderImage: placeholderImage, options: .avoidAutoSetImage)
            { [weak self] (image, error, cacheType, url) in
                if error != nil {
                    self?.image = placeholderImage
                } else {
                    self?.image = image
                }
            }
        }
    }

    func cancelImageDownloading() {
        sd_cancelCurrentImageLoad()
    }
}
