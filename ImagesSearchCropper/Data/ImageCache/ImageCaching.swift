
import UIKit
protocol ImageCachingProtocol {
    func image(url: URL) -> UIImage?
    func insert(image: UIImage, url: URL)
}

final class ImageCaching: ImageCachingProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    func image(url: URL) -> UIImage? {
        cache.object(forKey: url.absoluteString as NSString)
    }
 
    func insert(image: UIImage, url: URL) {
        let const = image.pngData()?.count ?? 0
        cache.setObject(image, forKey: url.absoluteString as NSString, cost: const)
    }
}
