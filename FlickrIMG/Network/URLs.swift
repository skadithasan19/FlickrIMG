//
//  URLs.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import Foundation

enum URLs {
    case flickrImages(searchItem: String)
    
    var url: URL? {
        switch self {
        case .flickrImages(let searchItem):
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.flickr.com"
            components.path = "/services/feeds/photos_public.gne"

            components.queryItems = [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "tags", value: searchItem)
            ]
            
            return components.url
        }
    }
}
