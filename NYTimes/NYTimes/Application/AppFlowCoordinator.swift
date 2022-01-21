//
//  AppFlowCoordinator.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import UIKit

class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let newsSceneDIContainer = appDIContainer.makeNewsSceneDIContainer()
        let flow = newsSceneDIContainer.makeNewsSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
    
    func setNavigationController(_ nav : UINavigationController){
        
    }
}

