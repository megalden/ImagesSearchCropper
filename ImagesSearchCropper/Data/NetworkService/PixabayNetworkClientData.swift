
import Foundation

protocol PixabayNetworkClientDataProtocol {
    func fetchPhoto(query: String) async throws -> PixabayModel
}

final class PixabayNetworkClientData: PixabayNetworkClientDataProtocol {
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchPhoto(query: String) async throws -> PixabayModel {
        guard let url = PixabayEndpoint.getPhotos(query: query).url else {
            throw NetworkError.invalidURL
        }
        
        let result: PixabayModel = try await networkClient.fetchData(url: url)
        return result
    }
}
