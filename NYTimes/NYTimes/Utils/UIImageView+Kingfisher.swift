//
//  UIImageView+Kingfisher.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation
import Kingfisher
import RxCocoa
import RxSwift

typealias ImageOptions = KingfisherOptionsInfo

enum ImageResult {
  case success(UIImage)
  case failure(Error)

  var image: UIImage? {
    if case .success(let image) = self {
      return image
    } else {
      return nil
    }
  }

  var error: Error? {
    if case .failure(let error) = self {
      return error
    } else {
      return nil
    }
  }
}

extension UIImageView {
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { result in
            let image = try? result.get().image
            if let image = image {
                self.image = image
            } else {
                // 캐시가 없다면
                guard let url = URL(string: urlString) else {
                    return
                }
                let resource = ImageResource(
                    downloadURL: url,
                    cacheKey: urlString
                )
                self.kf.setImage(with: resource) 
            }
        }
    }
}

