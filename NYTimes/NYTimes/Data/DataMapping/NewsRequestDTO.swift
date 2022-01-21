//
//  NewsRequestDTO.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import Foundation

struct NewsRequestDTO : ModelType{
    
    let api_key : String = "oe7VGSodL1fopHCAnSJxSWKjcqK0vWrk"
    
    private enum CodingKeys: String, CodingKey {
        case api_key = "api-key"
    }
}
