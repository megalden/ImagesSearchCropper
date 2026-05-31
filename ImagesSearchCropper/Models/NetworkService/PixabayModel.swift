
struct PixabayModel: Decodable {
    let hits: [Hit]
    
    struct Hit: Decodable {
        let id: Int
        let previewURL: String
        let largeImageURL: String
    }
}
