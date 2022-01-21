//
//  MediaObj.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

struct MediaObj: ModelType  {

    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approved_for_syndication: Int
    let media_metadata: [MetaData]

    private enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case media_metadata = "media-metadata"
    }
}
