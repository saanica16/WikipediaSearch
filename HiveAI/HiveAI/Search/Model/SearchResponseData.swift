//
//  SearchResponseData.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 01/03/24.
//

import Foundation

struct SearchResponseData: Decodable {
    let batchcomplete: String?
    let query: Query?
    let limits: Limits?
}

struct Limits: Decodable {
    let pageimages: Int?
    let extracts: Int?
}

struct Query: Decodable {
    let pages: [String: WikipediaData]?
}

struct WikipediaData: Decodable {
    let pageid: Int?
    let title: String?
    let thumbnail: Thumbnail?
    let extract: String?
}

struct Thumbnail: Decodable {
    let source: String?
    let width: Int?
    let height: Int?
}

struct SearchData {
    let searchString: String
    let gsrlimit: Int
}

struct ResultData {
    let title: String
    let description: String
    let imageData: Thumbnail?
}
