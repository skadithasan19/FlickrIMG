//
//  FlickrViewModel.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//
import Foundation
import Combine

class FlickrViewModel: ObservableObject, FlickrServiceProtocol, Loadable {
    
    typealias Output = FlickrResponse
    
    var apiSession: APISessionProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText = ""
    @Published var state: LoadingState<Output> = .idle
    
    init(apiSession: APISessionProtocol = APISession(), searchText: String = "") {
        self.apiSession = apiSession
        self.searchText = searchText
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self else { return }
                self.load()
            }
            .store(in: &cancellables)
    }
    
    func load() {
        self.state = .loading
        
        if searchText.isEmpty {
            self.state = .idle
            return
        }
        self.searchFlickrImages(searchItem: searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self else { return }
                if case .failure(let error as NSError) = result {
                    print("Error with request: \(APIError.decodingError(error: error))")
                    self.state = .failed(error)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.state = .loaded(response)
            }.store(in: &cancellables)
    }
}
