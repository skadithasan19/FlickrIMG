//
//  FlickrResponse.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//
import Foundation

// Root Data Model
struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Item]
}

// Nested Item Model
struct Item: Codable, Identifiable {
    var id = UUID()
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorID: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media, description, published, author, tags
        case dateTaken = "date_taken"
        case authorID = "author_id"
    }
}

extension Item {
    var imageSize: CGSize? {
        let pattern = #"width=\"(\d+)\".*height=\"(\d+)\""# // Regular expression to extract width and height
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let nsRange = NSRange(description.startIndex..<description.endIndex, in: description)
        
        if let match = regex?.firstMatch(in: description, options: [], range: nsRange),
           let widthRange = Range(match.range(at: 1), in: description),
           let heightRange = Range(match.range(at: 2), in: description),
           let width = Int(description[widthRange]),
           let height = Int(description[heightRange]) {
            return CGSize(width: width, height: height)
        }
        return nil
    }
}

// Nested Media Model
struct Media: Codable {
    let m: String
}

