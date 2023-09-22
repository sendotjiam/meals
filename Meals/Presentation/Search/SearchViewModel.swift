//
//  SearchViewModel.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift
import RxRelay

final class SearchViewModel {
    var loadingSubject = BehaviorRelay<Bool>(value: false)
    var dataSubject = PublishSubject<Void>()
    
    var displayData = [MealModel]()
    
    private var keyword = ""
    
    private let useCase: SearchMealsUseCaseProtocol
    private let bag = DisposeBag()
    
    init(with useCase: SearchMealsUseCaseProtocol = SearchMealsUseCase()) {
        self.useCase = useCase
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func onSearch(keyword: String) {
        self.keyword = keyword
        search()
    }
}

extension SearchViewModel {
    private func search() {
        loadingSubject.accept(true)
        useCase.execute(with: keyword).subscribe({ [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let models):
                self.displayData = models
                self.dataSubject.onNext(())
            case .error(let error):
                self.dataSubject.onError(error)
            case .completed: return
            }
            self.loadingSubject.accept(false)
        }).disposed(by: bag)
    }
}
