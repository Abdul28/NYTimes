//
//  NewsListViewModel.swift
//  NYTimes
//
//  Created by Abdul on 1/21/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt


protocol NewsListViewModelProtocol: ViewModelType {
    /// The corresponding borders
    ///
    ///

    var searchNews : BehaviorRelay<String> { get }
    var filterNews : BehaviorRelay<[NewsListItemViewModel]> { get }
}

final class NewsListViewModel : NewsListViewModelProtocol {
    


    var searchNews: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    var filterNews : BehaviorRelay<[NewsListItemViewModel]> = BehaviorRelay.init(value: [])

    private let disposable = DisposeBag()

    
    lazy var searchNewsObserable : Observable<String> = self.searchNews.asObservable()
    lazy var filteredNewsObserable : Observable<[NewsListItemViewModel]> = self.filterNews.asObservable()

    let news: BehaviorSubject<[NewsListItemViewModel]> = BehaviorSubject<[NewsListItemViewModel]>(value: [])
    
    let loading = BehaviorRelay<Bool>(value: false)
       
    
    var pageIndex: Int = 1
       
    let error = PublishSubject<Swift.Error>()
       
    let disposeBag = DisposeBag()
       
    var isAllLoaded = false
    

    struct Input {
        
        var viewWillAppear: Driver<Void>

        let loadNextPageTrigger: PublishSubject<Void> = PublishSubject<Void>()
        
        let didSelectCell: Driver<NewsListItemViewModel>
        
    }
    
    struct Output {
        let news: BehaviorSubject<[NewsListItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let didSelectCell: Driver<NewsListItemViewModel>
        
        let error: Driver<Error>
    }
    
    private let listNewsUseCase: MostViewedNewsUserProtocol

    private let coordinator: NewsFlowCoordinator


    init(listNewsUseCase : MostViewedNewsUserProtocol , coordinator: NewsFlowCoordinator){
        self.listNewsUseCase = listNewsUseCase
        self.coordinator = coordinator
        self.setSearchObserveable()
    }
    
    func setSearchObserveable(){
        
        searchNewsObserable.subscribe(onNext: { (value) in
            self.news.asObservable().map({ $0.filter({
                if value.isEmpty { return true}
                return ($0.title.lowercased().contains(value.lowercased()) || $0.author.lowercased().contains(value.lowercased()))})
            }).bind(to: self.filterNews)
                .disposed(by: self.disposable)
        }).disposed(by: self.disposable)
        
    }

    func transform(input: Input) -> Output {

        let activityIndicator = ActivityIndicator()

        let errorTracker = ErrorTracker()

        let queryRequest = loading.asObservable()
            .sample(input.viewWillAppear.asObservable())
            .flatMap { (loading) -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { observer in

                        observer.onNext(1)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }

        let nextPageRequest = loading.asObservable()
            .sample(input.loadNextPageTrigger)
            .flatMap { [unowned self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard !self.isAllLoaded else { return Observable.empty() }

                    return Observable<Int>.create { [unowned self] observer in
                        self.pageIndex += 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }


        let pageMerge = Observable.merge(queryRequest,nextPageRequest).share(replay: 1, scope: .forever)

        let request = Observable.combineLatest(pageMerge, input.viewWillAppear.asObservable())


        let response = request.flatMapLatest { [unowned self] (page, query)
            -> Observable<[NewsListItemViewModel]> in

            return self.listNewsUseCase.excute()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .catchErrorJustReturn(NewsPage(status: "FAILED", copyright: "", num_results: 0, news: []))
                .map {
                    $0.news.map {NewsListItemViewModel(with: $0)}
                    
                }

        }


        Observable
         .combineLatest(request, response, news.asObservable()) { [weak self] _, response, news in
             self?.isAllLoaded = response.count < 20
             return self?.pageIndex == 1 ? response : news + response
        }
        .sample(response)
        .bind(to: news)
        .disposed(by: disposeBag)

         Observable
             .merge(request.map {_ in true },
                    response.map { _ in false },
                    error.map { _ in false })
             .bind(to: loading)
             .disposed(by: disposeBag)

        let fetching = activityIndicator.asDriver()

        let didSelectCell = input.didSelectCell.do(onNext: { [weak self] (viewModel) in
            self?.coordinator.showNewsDetail(news: viewModel.news)
        })
        
        return Output(news: news, fetching: fetching, didSelectCell: didSelectCell, error: errorTracker.asDriver())

    }
    
    
    
}
