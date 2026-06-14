
import SwiftUI

struct ImageZoomView: View {
    var image: ImageItem
    
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { proxy in
            Image(uiImage: image.image)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .offset(offset)
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
                .contentShape(Rectangle())
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let newScale = lastScale * value
                            scale = min(max(newScale, 1), 5)
                        }
                        .onEnded { _ in
                            lastScale = scale
                            
                            if scale == 1 {
                                withAnimation(.spring()) {
                                    offset = .zero
                                    lastOffset = .zero
                                }
                            }
                        }
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            guard scale > 1 else { return }
                            
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            guard scale > 1 else { return }
                            lastOffset = offset
                        }
                )
                .onTapGesture(count: 2) {
                    withAnimation(.spring()) {
                        if scale > 1 {
                            scale = 1
                            lastScale = 1
                            offset = .zero
                            lastOffset = .zero
                        } else {
                            scale = 2
                            lastScale = 2
                        }
                    }
                }
        }
    }
}

#Preview {
    ImageZoomView(
        image: ImageItem(
            id: 0,
            url: URL(string: "https://pixabay.com/get/g887fa712a2ec98b5e11bc62c9da869584470e4989e52c8a70ff89a90f7f0d50277d67594a74015092156c7d62de157f22803ec8fa54ee189eaa322e9929a9d93_640.jpg")!,
            image: .previem
        )
    )
}
