
import Foundation
import UIKit

protocol ImageRepositoryProtocol {
    func searchImages(query: String) -> AsyncThrowingStream<ImageItem, Error>
}

final class ImageRepository: ImageRepositoryProtocol {
    let networkClient: PixabayNetworkClientDataProtocol
    let imageLoader: ImageLoaderProtocol
    let imageCaching: ImageCachingProtocol
    
    init(
        networkClient: PixabayNetworkClientDataProtocol,
        imageLoader: ImageLoaderProtocol,
        imageCaching: ImageCachingProtocol
    ) {
        self.networkClient = networkClient
        self.imageLoader = imageLoader
        self.imageCaching = imageCaching
    }
    
    func searchImages(query: String) -> AsyncThrowingStream<ImageItem, Error>  {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let model = try await networkClient.fetchPhoto(query: query)
                    
                    for photo in model.hits {
                        guard let id = photo.id,
                              let url = photo.webformatURL
                        else {
                            continue
                        }
                        
                        if let cached = imageCaching.image(url: url) {
                            continuation.yield(
                                ImageItem(
                                    id: id,
                                    url: url,
                                    image: cached
                                )
                            )
                        }
                        
                        guard let loadedImage = await imageLoader.loadImage(url: url) else {
                            continue
                        }
                        
                        imageCaching.insert(image: loadedImage, url: url)
                        
                        continuation.yield(
                            ImageItem(
                                id: id,
                                url: url,
                                image: loadedImage
                            )
                        )
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
