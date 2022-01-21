//
//  NewsDetailsViewModel.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

final class NewsDetailsViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let title: String
        let author: String
        let abstract : String
        let posterImage: String
        let isPosterImageHidden: Bool
        let overview: String
    }
    
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
    func transform(input: Input) -> Output {
        return Output(
            title: news.title ?? "",
            author: news.byline ?? "",
            abstract: news.abstract ?? "",
            posterImage: news.mediaUri.url,
            isPosterImageHidden: true,
            overview: news.title ?? ""
        )
    }
    
}
