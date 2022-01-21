//
//  MetaData.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

struct MetaData: ModelType {

    let url: String!
    let format: String!
    let height: Int
    let width: Int
    
    private enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
}
