//
//  PhotoView.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import SwiftUI

struct PhotoView: View {
    
    private var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        AsyncImage(url: URL(string: item.media.m)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .accessibilityLabel("Loading image")
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel(item.title)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .accessibilityLabel("Failed to load image")
                    .accessibilityIdentifier("Failed to load image")
            @unknown default:
                EmptyView()
                    .accessibilityHidden(true)
            }
        }
    }
}
