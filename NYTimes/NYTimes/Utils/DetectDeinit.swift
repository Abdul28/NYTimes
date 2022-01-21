//
//  DetectDeinit.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation

class DetectDeinit: NSObject {
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
      log.verbose("DEINIT: \(self.className)")
    }
    
}
