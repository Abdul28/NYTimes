//
//  NewsSceneDIContainer.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit

final class NewsSceneDIContainer {
    
    struct Dependencies {
        let newsNetworking: NewsNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeMostVisitedNewsUseCase() -> MostViewedNewsUserProtocol {
        return MostViewedNewsUserCase(newsRepository: makeNewsRepository())
    }
    
    // MARK: - Repositories
    func makeNewsRepository() -> NewsRepository {
        return NewsDAO(network: dependencies.newsNetworking)
    }
    
    // MARK: - News List
    func makeNewsListViewController(
        coordinator: NewsFlowCoordinator
    ) -> NewsListViewController {
        NewsListViewController.create(
            with: makeNewsListViewModel(coordinator: coordinator)
        )
    }
    
    func makeNewsListViewModel(
        coordinator: NewsFlowCoordinator
    ) -> NewsListViewModel {
        return NewsListViewModel(listNewsUseCase: makeMostVisitedNewsUseCase(), coordinator: coordinator)
    }
     
    
    // MARK: - News Detail
    func makeNewsDetailsViewController(
        news: News
    ) -> NewsDetailsViewController {
        return NewsDetailsViewController.create(
            with: makeNewsDetailsViewModel(news: news)
        )
    }
    
    func makeNewsDetailsViewModel(news: News) -> NewsDetailsViewModel {
        return NewsDetailsViewModel(news: news)
    }
    
    
    // MARK: - Flow Coordinators
    func makeNewsSearchFlowCoordinator(
        navigationController: UINavigationController
    ) -> NewsFlowCoordinator {
          return DefaultNewsFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
}

extension NewsSceneDIContainer: NewsFlowCoordinatorDependencies {}
