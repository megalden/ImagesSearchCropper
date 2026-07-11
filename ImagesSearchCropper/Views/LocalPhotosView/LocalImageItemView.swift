

import SwiftUI

struct LocalImageItemView: View {
    @Binding var image: UIImage
    @State private var isShowingCropper = false
    @State private var imageToCrop: UIImage?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Image(uiImage: image)
                .resizable()
            
            Button {
                imageToCrop = image
                isShowingCropper = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color.userGray)
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "rectangle.dashed")
                        .foregroundStyle(Color.darkPurple)
                }
            }
            .padding(22)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .aspectRatio(1.5, contentMode: .fit)
        .fullScreenCover(isPresented: $isShowingCropper) {
            if let imageToCrop {
                ImageCropperView(image: imageToCrop) { cropped in
                    image = cropped
                    
                    isShowingCropper = false
                } onCancel: {
                    isShowingCropper = false
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LocalImageItemView(image: .constant(UIImage(systemName: "photo")!))
}
