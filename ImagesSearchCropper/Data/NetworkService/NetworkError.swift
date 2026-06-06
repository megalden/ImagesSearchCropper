import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidApiKey
    case noData
    case decodingError
    case badStatusCode(Int)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidApiKey:
            return "Invalid API key"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .badStatusCode(let code):
            return "Bad status code: \(code)"
        }
    }
}
