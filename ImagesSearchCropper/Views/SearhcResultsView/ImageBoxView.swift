

import SwiftUI

struct ImageBoxView: View {
    var image: PixabayModel.Hit
    
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                
                if let url = image.largeImageURL {
                    ShareLink(item: url) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.userGray)
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(Color.darkPurple)
                        }
                    }
                    .padding(22)
                }
            } else if imageLoader.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .font(.system(size: 32))
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .task(id: image.largeImageURL) {
            await imageLoader.load(from: image.largeImageURL)
        }
    }
}

#Preview {
    ImageBoxView(
        image: PixabayModel.Hit(
            id: 5668882,
            previewURL: URL(string: "https://cdn.pixabay.com/photo/2020/10/19/19/58/chrysanthemum-5668882_150.jpg"),
            largeImageURL: URL(string: "https://pixabay.com/get/ge0554e2fa9ccbc2006c57697c977a58e6755d22f11f08d9c3728ee01b38f6afba551d21007e2692f92efc7139d6fa5b1e40fc43a1b82d809932c5ec31cdd6d1e_1280.jpg")
        )
    )
}
