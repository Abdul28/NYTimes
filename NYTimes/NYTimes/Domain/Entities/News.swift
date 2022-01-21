//
//  News.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

struct News: Equatable, Identifiable {

    let uri: String?
    let url: String?
    let id: UInt64?
    let asset_id: UInt64?
    let source: String?
    let published_date: Date?
    let updated: Date?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adx_keywords: String?
    let byline: String?
    let title: String?
    let abstract: String?
    let mediaUri: NewsImage

}

struct NewsImage: Equatable {

    let url: String!
    let format: String!
    let height: Int
    let width: Int

}


struct NewsPage: Equatable {
    let status: String
    let copyright: String
    let num_results: Int
    let news: [News]
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case result = "num_results"
        case news = "results"
    }
}
