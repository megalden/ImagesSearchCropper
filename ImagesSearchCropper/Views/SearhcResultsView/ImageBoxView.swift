

import SwiftUI

struct ImageBoxView: View {
    var image: PixabayModel.Hit
    
    var body: some View {
        
    }
}

#Preview {
    ImageBoxView(
        image: PixabayModel.Hit(
            id: 195893,
            previewURL: URL(string: "https://cdn.pixabay.com/photo/2013/10/15/09/12/flower-195893_150.jpg"),
            largeImageURL: URL(string: "https://pixabay.com/get/ed6a99fd0a76647_1280.jpg")
        )
    )
}
