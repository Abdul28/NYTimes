//
//  AppDIContainer.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

final class AppDIContainer {
    
    func makeNewsSceneDIContainer() -> NewsSceneDIContainer {
        let dependencies = NewsSceneDIContainer.Dependencies(newsNetworking: NewsNetworking())
        return NewsSceneDIContainer(dependencies: dependencies)
    }
    
}
