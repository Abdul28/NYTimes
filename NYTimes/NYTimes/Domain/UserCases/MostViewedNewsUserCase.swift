//
//  MostViewedNewsUserCase.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import RxSwift

protocol MostViewedNewsUserProtocol{
    
    func excute(query: NewsQuery, page: Int) -> Single<NewsPage>
    func excute() -> Single<NewsPage>

}

class MostViewedNewsUserCase: DetectDeinit, MostViewedNewsUserProtocol {
    
    func excute() -> Single<NewsPage> {
        return newsRepository.fetchNewsList()
    }
    
    
    private let newsRepository: NewsRepository
    
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func excute(query: NewsQuery, page: Int) -> Single<NewsPage> {
        return newsRepository.fetchNewsList()
    }
    
}
