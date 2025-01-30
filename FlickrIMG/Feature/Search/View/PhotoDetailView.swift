//
//  PhotoDetailView.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import SwiftUI

struct PhotoDetailView: View {
    
    private var item: Item
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        List {
            Section(header: Text("Photo")) {
                PhotoView(item: item)
                HorizontalLabel(labelName: "Date", value: item.dateTaken)
                HorizontalLabel(labelName: "Published", value: item.published)
                if let dimensions = item.imageSize {
                    HorizontalLabel(labelName: "Dimensions", value: "\(dimensions.width) x \(dimensions.height) px")
                } else {
                    Text("Dimensions not available")
                        .foregroundColor(.gray)
                }
                Link("View on Flickr", destination: URL(string: item.link)!)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            Section(header: Text("Author")) {
                HorizontalLabel(labelName: "Email", value: item.author)
                HorizontalLabel(labelName: "ID", value: item.authorID)
                HorizontalLabel(labelName: "Email", value: item.author)
            }
            
            Section {
                if let link = URL(string: item.link) {
                    ShareLink("Share",
                              item: link, // The URL to share
                              preview: SharePreview(item.title, image: Image(systemName: "photo"))
                    )
                    .font(.headline)
                    .foregroundColor(.blue)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(item.title)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
                .accessibilityIdentifier("BackButton") // Set identifier for UI test
            }
        }
    }
}

struct HorizontalLabel: View {
    
    private var labelName: String
    private var value: String
    
    init(labelName: String, value: String) {
        self.labelName = labelName
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(labelName)
                .fontWeight(.semibold)
            Divider()
            Text(value)
        }
    }
}
