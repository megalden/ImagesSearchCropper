
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case badStatusCode(Int)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .badStatusCode(let code):
            return "Bad status code: \(code)"
        }
    }
}
