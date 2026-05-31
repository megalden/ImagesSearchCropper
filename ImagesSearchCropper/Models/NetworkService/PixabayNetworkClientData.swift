
import Foundation

protocol PixabayNetworkClientDataProtocol {
    func fetchPhoto(q: String) async throws -> [PixabayModel.Hit]
}

final class PixabayNetworkClientData: PixabayNetworkClientDataProtocol {
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchPhoto(q: String) async throws -> [PixabayModel.Hit] {
        guard let url = PixabayEndpoint.getPhotos(q: q).url else {
            throw NetworkError.invalidURL
        }
        return try await networkClient.fetchData(url: url)
    }
}
