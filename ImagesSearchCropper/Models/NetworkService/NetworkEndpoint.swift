import Foundation

enum PixabayEndpoint {
    case getPhotos(q: String)
    
    private var baseURL: String {
        "https://pixabay.com/api"
    }
    private var publicAPIKey: String? {
        Bundle.main.object(forInfoDictionaryKey: "PublicAPIKey") as? String
    }
    
    var url: URL? {
        guard let publicAPIKey else {
            return nil
        }
        
        switch self {
        case let .getPhotos(q):
            var components = URLComponents(string: baseURL)
            components?.queryItems = [
                .init(name: "key", value: publicAPIKey),
                .init(name: "q", value: q),
                .init(name: "image_type", value: "photo"),
            ]
            return components?.url
        }
    }
}


