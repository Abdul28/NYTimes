//
//  NewsRepository.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import RxSwift

protocol NewsRepository {
    
//    func fetchNewsList(query: NewsQuery, page: Int) -> Single<NewsPage>
    func fetchNewsList() -> Single<NewsPage>

}
