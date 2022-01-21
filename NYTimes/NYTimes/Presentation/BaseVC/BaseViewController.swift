//
//  BaseViewController.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    @objc func showSearch(){};
    @objc func showOptions(){};
    @objc func showMenu(){};
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
      log.verbose("DEINIT: \(self.className)")
    }

    // MARK: Rx
    var disposeBag = DisposeBag()

    
    func setNavigation(_ addButtons : Bool){
       
       
        if addButtons{
            self.addNavLeftItems()
            self.addNavRightItems()
        }
        self.setupBackButton()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = AppColor.appPrimaryColor // Replace with color you desire
        view.addSubview(statusBarView)

    }
    
    public func addNavRightItems() {
        let searchBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        let optionsBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_options"), style: .plain, target: self, action: #selector(showMenu))
        self.navigationItem.rightBarButtonItems  = [optionsBarButtonItem,searchBarButtonItem]
    }
    
    public func addNavLeftItems() {
        
        let menuBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(showMenu))

        self.navigationItem.leftBarButtonItem  = menuBarButtonItem
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





extension Reactive where Base: UIViewController {
    
    var viewDidLoad: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidLoad)))
    }
    
    var viewWillAppear: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewWillAppear(_:))))
    }
    
    var viewWillLayoutSubviews: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewWillLayoutSubviews)))
    }
    
    var viewDidAppear: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidAppear(_:))))
    }
    
    var viewWillDisappear: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewWillDisappear(_:))))
    }
    
    var viewDidDisappear: ControlEvent<Void> {
        return ControlEvent(events: emptyMethodInvoked(#selector(Base.viewDidDisappear(_:))))
    }
    
    private func emptyMethodInvoked(_ selector: Selector) -> Observable<Void> {
        return methodInvoked(selector).map { _ in }
    }
}
