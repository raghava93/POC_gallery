//
//  Imageodel.swift
//  imageGallery
//
//  Created by Raghavendra reddy on 13/01/22.
//

import Foundation

struct ImageElement: Codable {
    let format: Format
    let width, height: Int
    let filename: String
    let id: Int
    let author: String
    let authorURL, postURL: String

    enum CodingKeys: String, CodingKey {
        case format, width, height, filename, id, author
        case authorURL = "author_url"
        case postURL = "post_url"
    }
}

enum Format: String, Codable {
    case jpeg = "jpeg"
}

typealias ImageList = [ImageElement]
