

import SwiftUI

struct ImageBoxView: View {
    var image: UIImage?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
//                if let image = image {
//                    ShareLink(item: image) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 5)
//                                .foregroundStyle(Color.userGray)
//                                .frame(width: 32, height: 32)
//                            
//                            Image(systemName: "square.and.arrow.up")
//                                .foregroundStyle(Color.darkPurple)
//                        }
//                    }
//                    .padding(22)
//                }
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
    ImageBoxView()
}
