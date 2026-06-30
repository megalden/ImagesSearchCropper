

import SwiftUI

struct LocalImageItemView: View {
    var body: some View {
        VStack {
            Image("previem")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 200, maxHeight: 200)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LocalImageItemView()
}
