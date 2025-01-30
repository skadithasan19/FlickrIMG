//
//  PhotoItemView.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//


import SwiftUI

struct PhotoItemView: View {
    
    private var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            PhotoView(item: item)
            Text(item.title)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .accessibilityLabel(item.title)
                .accessibilityHint("Title of the image.")
                .accessibilityIdentifier("PhotoTitle_\(item.id)") 
        }
    }
}
