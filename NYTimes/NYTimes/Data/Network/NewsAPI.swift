//
//  NewsAPI.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import Foundation
import Moya
import MoyaSugar

enum NewsAPI{
    case url(URL)
    case news(param: NewsRequestDTO)
}

extension NewsAPI: SugarTargetType {
    
    var baseURL: URL {
        return URL(string: "http://api.nytimes.com/svc/mostpopular/v2/")!
    }
    
    var url: URL {
        switch self {
        case .url(let url):
            return url
        default:
            return self.defaultURL
        }
    }
    
    var route: Route {
        switch self {
        case .url:
            return .get("")
        case .news:
            return .get("mostviewed/all-sections/7.json")
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .news(let param):
            return .init(encoding: URLEncoding.default, values: try! param.asDictionary())
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
      return ["Accept": "application/json"]
    }

    var sampleData: Data {
      return Data()
    }
    
}
