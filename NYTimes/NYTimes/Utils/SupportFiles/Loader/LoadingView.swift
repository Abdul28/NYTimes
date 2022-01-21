//
//  Extensions.swift
//  ECS
//
//  Created by Abdul on 10/29/19.
//  Copyright © 2019 Abdul. All rights reserved.
//

import UIKit
import GeometricLoaders

protocol LoadingView {
    func startLoading()
    func endLoading()
}

extension LoadingView where Self : UIViewController {
    
    func startLoading(){
        let loadingView = WaterWaves.createGeometricLoader()
        loadingView.circleColor = AppColor.appPrimaryColor
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.restorationIdentifier = "loaderAnimating"
        loadingView.startAnimation()
    }
    
    func endLoading(){
        
        for item in view.subviews
            where item.restorationIdentifier == "loaderAnimating" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
        
    }
}
