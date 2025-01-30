//
//  ContentView.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    
    @ObservedObject var viewModel: FlickrViewModel
    
    init(viewModel: FlickrViewModel = FlickrViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search for images", text: $viewModel.searchText, onCommit: {
                    viewModel.load()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityLabel("Search Bar")
                .accessibilityHint("Enter text to search for Flickr images.")
                .accessibilityIdentifier("Search Bar")
                // Display loading Indicator until get the data
                AsyncLoadableView(source: viewModel) { response in
                    if response.items.isEmpty {
                        Text("No images found. Try searching for something.")
                            .foregroundColor(.gray)
                            .padding()
                            .accessibilityLabel("No images found.")
                            .accessibilityHint("Try searching for another keyword.")
                    } else {
                        // Display Images in Grid
                        PhotoGridView(items: response.items)
                            .accessibilityElement(children: .contain)
                    }
                }
                Spacer()
            }
            .navigationTitle("Flickr Search")
            .accessibilityLabel("Flickr Search Screen")
        }
    }
}

#Preview {
    ContentView()
}
