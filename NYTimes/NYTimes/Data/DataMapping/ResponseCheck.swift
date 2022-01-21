//
//  ResponseCheck.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation


struct ResponseCheck : ModelType{
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case result = "num_results"
    }
    let status : String
    let copyright: String
    let result: Int
}


extension ResponseCheck {
    func toDomain() -> NewsPage {
        return .init(status: "", copyright: "", num_results: 0, news: [])
    }
}
