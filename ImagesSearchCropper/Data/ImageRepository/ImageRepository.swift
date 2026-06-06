
import Foundation
import UIKit

protocol ImageRepositoryProtocol {
    func searchImages(query: String) async throws -> [ImageItem]
}

final class ImageRepository: ImageRepositoryProtocol {
    let networkClient: PixabayNetworkClientDataProtocol
    let imageLoader: ImageLoaderProtocol
    let imageCaching: ImageCachingProtocol
    
    init(networkClient: PixabayNetworkClientDataProtocol, imageLoader: ImageLoaderProtocol, imageCaching: ImageCachingProtocol) {
        self.networkClient = networkClient
        self.imageLoader = imageLoader
        self.imageCaching = imageCaching
    }
    
    func searchImages(query: String) async throws -> [ImageItem] {
        let model = try await networkClient.fetchPhoto(query: query)
        
        var items: [ImageItem] = []
        
        for photo in model.hits {
            guard let id = photo.id,
                  let url = photo.largeImageURL
            else {
                continue
            }
            
            let image: UIImage?
            
            if let cached = imageCaching.image(url: url) {
                image = cached
            } else {
                image = await imageLoader.loadImage(url: url)
                
                if let image {
                    imageCaching.insert(image: image, url: url)
                }
            }
            
            if let image {
                items.append(
                    ImageItem(
                        id: id,
                        image: image)
                )
            }
        }
        return items
    }
}
