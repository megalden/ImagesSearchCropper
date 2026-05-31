import Foundation

enum PixabayEndpoint {
    case getPhotos(q: String)
    
    private var baseURL: String {
        "https://pixabay.com/api"
    }
    private var publicAPIKey: String {
        Bundle.main.object(forInfoDictionaryKey: "PublicAPIKey") as? String ?? NetworkError.invalidURL.localizedDescription
    }
    
    var url: URL? {
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


