import Foundation

struct PixabayModel: Decodable, Hashable {
    let hits: [Hit]
    
    struct Hit: Decodable, Hashable {
        let id: Int?
        let previewURL: URL?
        let largeImageURL: URL?
    }
}
