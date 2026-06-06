import SwiftUI

protocol ImageLoaderProtocol {
    func loadImage(url: URL?) async -> UIImage?
}

final class ImageLoader: ImageLoaderProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadImage(url: URL?) async -> UIImage? {
        guard let url else { return nil }
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                return nil
            }
            
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
