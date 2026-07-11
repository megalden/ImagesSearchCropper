import Foundation

enum PixabayEndpoint {
    case getPhotos(query: String)
    
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
        case let .getPhotos(query):
            var components = URLComponents(string: baseURL)
            components?.queryItems = [
                .init(name: "key", value: publicAPIKey),
                .init(name: "q", value: query),
                .init(name: "image_type", value: "photo"),
            ]
            return components?.url
        }
    }
}


