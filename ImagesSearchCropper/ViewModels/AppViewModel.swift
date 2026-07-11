
import SwiftUI
import Combine

final class AppViewModel: ObservableObject {
    enum Screen {
        case search
        case results
        case localImage
    }
    
    @Published var screen: Screen = .search
}
