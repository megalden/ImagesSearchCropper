
import UIKit
protocol ImageCachingProtocol {
    func image(url: URL) -> UIImage?
    func insert(image: UIImage, url: URL)
}

final class ImageCachingService: ImageCachingProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    init() {
        cache.totalCostLimit = 20 * 1920 * 1080
    }
    
    func image(url: URL) -> UIImage? {
        cache.object(forKey: url.absoluteString as NSString)
    }
 
    func insert(image: UIImage, url: URL) {
        let const = image.pngData()?.count ?? 0
        cache.setObject(image, forKey: url.absoluteString as NSString, cost: const)
    }
}
