import SwiftUI
import CropViewController
import TOCropViewController

struct ImageCropperView: UIViewControllerRepresentable {
    let image: UIImage
    var croppingStyle: CropViewCroppingStyle = .default
    var onCrop: (UIImage) -> Void
    var onCancel: () -> Void = {}

    func makeUIViewController(context: Context) -> CropViewController {
        let cropViewController = CropViewController(croppingStyle: croppingStyle, image: image)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }

    func updateUIViewController(_ uiViewController: CropViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, CropViewControllerDelegate {
        let parent: ImageCropperView

        init(parent: ImageCropperView) {
            self.parent = parent
        }

        func cropViewController(
            _ cropViewController: CropViewController,
            didCropToImage image: UIImage,
            withRect cropRect: CGRect,
            angle: Int
        ) {
            parent.onCrop(image)
        }

        func cropViewController(
            _ cropViewController: CropViewController,
            didFinishCancelled cancelled: Bool
        ) {
            parent.onCancel()
        }
    }
}
