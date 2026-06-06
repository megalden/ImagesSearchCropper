

import SwiftUI

struct ImagePageView: View {
    var image: ImageItem?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                if let uiImage = image?.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.userGray)
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "plus.magnifyingglass")
                                .foregroundStyle(Color.darkPurple)
                        }
                    }
                    .padding(22)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 32))
                        .foregroundStyle(.gray)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("APP License")
                            .foregroundStyle(Color.darkPurple)
                        Text("Free for commercial use")
                            .font(.system(size: 16))
                        Text("No attribution required")
                            .font(.system(size: 16))
                    }
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Photo in .JPG format")
                            .font(.system(size: 16))
                        
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color.darkPurple, style: StrokeStyle(lineWidth: 2))
                                    .frame(height: 30)
                                    .foregroundStyle(Color.darkPurple)
                                
                                HStack {
                                    Text("Share")
                                        .foregroundStyle(.black)
                                }
                                .font(.system(size: 14))
                            }
                        }
                    }
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 70)
                            .foregroundStyle(Color.darkPurple)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Download")
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                    }
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    ImagePageView(
        image: ImageItem(
            id: 0,
            url: URL(string: "https://pixabay.com/get/g887fa712a2ec98b5e11bc62c9da869584470e4989e52c8a70ff89a90f7f0d50277d67594a74015092156c7d62de157f22803ec8fa54ee189eaa322e9929a9d93_640.jpg")!,
            image: .previem
        )
    )
}
