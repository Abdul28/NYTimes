//
//  NewsFlowCoordinator.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit

protocol NewsFlowCoordinatorDependencies {
    
    func makeNewsListViewController(coordinator: NewsFlowCoordinator) -> NewsListViewController
    
    func makeMovieDetailsViewController(news: News) -> NewsDetailsViewController
}

protocol NewsFlowCoordinator {
    
    func start()
    
    func showNewsDetail(news: News)
}

class DefaultNewsFlowCoordinator: NewsFlowCoordinator {
    
    private let navigationController: UINavigationController
    
    private let dependencies: NewsFlowCoordinatorDependencies
    
    
    init(navigationController: UINavigationController,
         dependencies: NewsFlowCoordinatorDependencies) {
        
        self.navigationController = navigationController
        self.navigationController.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController.navigationBar.layer.shadowRadius = 4.0
        self.navigationController.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController.navigationBar.layer.masksToBounds = false
        self.navigationController.navigationBar.tintColor = .white
        self.navigationController.navigationBar.barTintColor = AppColor.appPrimaryColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController.navigationBar.titleTextAttributes = textAttributes
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeNewsListViewController(coordinator: self)
        navigationController.navigationItem.backBarButtonItem?.title = ""
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showNewsDetail(news: News) {
        let vc = dependencies.makeMovieDetailsViewController(news: news)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
