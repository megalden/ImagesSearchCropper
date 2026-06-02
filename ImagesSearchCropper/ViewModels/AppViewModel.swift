
import SwiftUI
import Combine

final class AppViewModel: ObservableObject {
    enum Screen {
        case search
        case results
    }
    
    @Published var screen: Screen = .search
}
