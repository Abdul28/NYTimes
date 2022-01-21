//
//  NewsListViewController.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import AVFoundation


class NewsListViewController: BaseViewController, StoryboardInstantiable, Alertable {

    var searchBar: UISearchBar!
    var searchResult : NewsResponseDTO?
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private var emptyLabel: UILabel!
    
    private var viewModel: NewsListViewModel!
    
    lazy var searchController : UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        let textFieldInsideSearchBar = controller.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        controller.searchBar.barTintColor = AppColor.appPrimaryColor
        controller.searchBar.tintColor = AppColor.appSecondaryColor
        controller.searchBar.placeholder = "Search News ......"
        return controller
    })()
    
    
    static func create(with viewModel: NewsListViewModel) -> NewsListViewController {
        
        let view = NewsListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.title = "NY Times Most Popular"
        self.navigationItem.title = "NY Times Most Popular"
        initView()
        setupRx()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }

    

    override func showSearch()  {
        tableView.setContentOffset(CGPoint.init(x: 0, y: tableView.contentOffset.y == 0 ?  searchBar.frame.size.height : 0), animated: true)
        if tableView.contentOffset.y != 0{
            searchBar.becomeFirstResponder()
        }
    }
    

    private func initView() {
        
        self.setNavigation(true)

        searchBar = searchController.searchBar
        searchBar.rx
           .cancelButtonClicked
           .asDriver(onErrorJustReturn: ())
           .drive(onNext: { [weak searchBar] in
              searchBar?.resignFirstResponder()
              self.showSearch()
           })
           .disposed(by: disposeBag)
        bindSeachbar()
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint.init(x: 0, y: searchBar.frame.size.height)
        tableView.estimatedRowHeight = NewsListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
        

        
        activityIndicator = UIActivityIndicatorView(frame:
            CGRect(
                x: UIScreen.main.bounds.size.width * 0.5,
                y: UIScreen.main.bounds.size.height * 0.5,
                width: 20,
                height: 20)
        )

        self.view.addSubview(activityIndicator)
        
    }
    
    func bindSeachbar() {
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchNews)
            .disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()

    }
    
    
    private func setupRx() {
        assert(viewModel != nil )
        let didSelect = tableView.rx
            .modelSelected(NewsListItemViewModel.self)
            .asDriver()
        let input = NewsListViewModel.Input(viewWillAppear:  rx.viewWillAppear.asDriver(), didSelectCell: didSelect)
        
        tableView.rx.reachedBottom()
            .do(onNext: { _ in
//                log.debug("reachedBottom reachedBottom reachedBottom")
            })
            .bind(to: input.loadNextPageTrigger)
            .disposed(by: disposeBag)
                
        viewModel.filterNews.asDriver(onErrorJustReturn: []).drive(
            tableView.rx.items(
                cellIdentifier: NewsListItemCell.reuseIdentifier,
                cellType: NewsListItemCell.self)) { _, viewModel, cell in
                    cell.bind(viewModel)
            }.disposed(by: disposeBag)
                    
        let output = viewModel.transform(input: input)
        
        output.fetching
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.error.drive(onNext: { (error) in
            log.error("error \(error)")
        }).disposed(by: disposeBag)
        
        output.didSelectCell
            .drive()
            .disposed(by: disposeBag)
    }

}
