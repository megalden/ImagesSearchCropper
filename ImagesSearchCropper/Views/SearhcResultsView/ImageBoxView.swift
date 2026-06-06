

import SwiftUI

struct ImageBoxView: View {
    var image: ImageItem?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let uiImage = image?.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                if let url = image?.url {
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
            }
            else {
                Image(systemName: "photo")
                    .font(.system(size: 32))
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ImageBoxView(
        image: ImageItem(
            id: 0,
            url: URL(string: "https://pixabay.com/get/g887fa712a2ec98b5e11bc62c9da869584470e4989e52c8a70ff89a90f7f0d50277d67594a74015092156c7d62de157f22803ec8fa54ee189eaa322e9929a9d93_640.jpg")!,
            image: .previem
        )
    )
}
