//
//  Loadable.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import SwiftUI

protocol Loadable: ObservableObject {
  associatedtype Output
  var state: LoadingState<Output> { get }
  func load()
}

enum LoadingState<Output> {
  case idle
  case failed(Error)
  case loaded(Output)
  case loading
}


struct AsyncLoadableView<Source: Loadable, Content: View>: View {
  @ObservedObject var source: Source
  var content: (Source.Output) -> Content
  
  init(source: Source, @ViewBuilder content: @escaping(Source.Output) -> Content) {
    self.source = source
    self.content = content
  }
    var body: some View {
      switch source.state {
      case .failed(let error):
        Text(error.localizedDescription)
      case .idle:
        EmptyView()
      case .loading:
        ProgressView()
      case .loaded(let output):
        content(output)
      }
    }
}
