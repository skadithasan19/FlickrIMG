//
//  PhotoGridView.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import SwiftUI

struct PhotoGridView: View {
    
    private var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    NavigationLink(destination: PhotoDetailView(item: item)) {
                        PhotoItemView(item: item)
                    }
                    .accessibilityIdentifier("GridItem_\(index)")
                }
            }
            .padding()
        }
    }
}
