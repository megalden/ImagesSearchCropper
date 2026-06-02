//
//  SearhcResultsView.swift
//  ImagesSearchCropper
//
//  Created by Володимир Галушка on 02.06.2026.
//

import SwiftUI

struct SearhcResultsView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBoxView(searchText: $searchText)
            VStack {
                
            }
        }
    }
}

#Preview {
    SearhcResultsView()
}
