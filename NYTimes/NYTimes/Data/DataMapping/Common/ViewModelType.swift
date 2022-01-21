//
//  ViewModelType.swift
//  NYTimes
//
//  Created by Abdul on 1/20/22.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
