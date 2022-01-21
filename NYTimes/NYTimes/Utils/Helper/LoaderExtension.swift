//
//  LoaderExtension.swift
//  ECS
//
//  Created by Abdul on 10/29/19.
//  Copyright © 2019 Abdul. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension UIViewController: LoadingView {}

extension Reactive where Base : UIViewController{
    
    public var isAnimating : Binder<Bool>{
        
        return Binder(self.base, binding: { (vc, active) in
            vc.startLoading()
            
            if active {
                vc.startLoading()
            } else {
                vc.endLoading()
            }
        })
    }
}
