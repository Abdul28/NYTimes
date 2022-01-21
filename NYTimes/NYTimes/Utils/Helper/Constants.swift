//
//  Constants.swift
//  ECS
//
//  Created by Abdul on 10/29/19.
//  Copyright © 2019 Abdul. All rights reserved.
//

import UIKit

struct AppColor {
    
    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.8)
        static let SemiTransparent = CGFloat(0.5)
        static let Transparent = CGFloat(0.3)
    }
    
    static let appPrimaryColor =  UIColor.init(red: 71.0/255.0, green: 228.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    static let appSecondaryColor =  UIColor.white.withAlphaComponent(Alphas.Opaque)
    
    struct TextColors {
        static let Error = AppColor.appSecondaryColor
        static let Success = UIColor(red: 0.1303, green: 0.9915, blue: 0.0233, alpha: Alphas.Opaque)
    }
    
    struct TabBarColors{
        static let Selected = UIColor.white
        static let NotSelected = UIColor.black
    }
    
    struct OverlayColor {
        static let SemiTransparentBlack = UIColor.black.withAlphaComponent(Alphas.Transparent)
        static let SemiOpaque = UIColor.black.withAlphaComponent(Alphas.SemiOpaque)
        static let demoOverlay = UIColor.black.withAlphaComponent(0.6)
    }
    
}
