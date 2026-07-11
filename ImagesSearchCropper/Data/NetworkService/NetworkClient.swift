
import Foundation

protocol NetworkClientProtocol {
    func fetchData<T: Decodable>(url: URL) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    internal func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw  NetworkError.badStatusCode(httpResponse.statusCode)
        }
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return decoded
    }
}
