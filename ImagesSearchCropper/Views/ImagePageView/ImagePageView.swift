

import SwiftUI

struct ImagePageView: View {
    var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                if let uiImage = image {
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
    ImagePageView()
}
