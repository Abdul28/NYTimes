//
//  NewsDAO.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import RxSwift

class NewsDAO: DetectDeinit, NewsRepository{
        
    private let network: NewsNetworking
    
    init(network: NewsNetworking) {
        self.network = network
    }
    
    func fetchNewsList(query: NewsQuery, page: Int) -> Single<NewsPage> {

        let requsetDTO = NewsRequestDTO()

        return network.request(.news(param: requsetDTO))
            .map(NewsResponseDTO.self)
            .map{ $0.toDomain() }
            .do(onSuccess: { (response) in
//                log.debug("response \(response.news) page \(response.num_results)")
            })
    }
    
    func fetchNewsList() -> Single<NewsPage> {
        
        let requsetDTO = NewsRequestDTO()

        return network.request(.news(param: requsetDTO))
            .map(NewsResponseDTO.self)
            .map{ $0.toDomain() }
            .do(onSuccess: { (response) in
//                log.debug("response \(response.news) page \(response.num_results)")
            })
    }

    
}
