//
//  MealListViewModel.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift
import RxRelay

final class MealListViewModel {
    
    var loadingSubject = BehaviorRelay<Bool>(value: false)
    var dataSubject = PublishSubject<Void>()
    
    var displayData = [MealModel]()
    
    private let useCase: FetchMealsByLetterUseCaseProtocol
    private let bag = DisposeBag()
    
    init(with useCase: FetchMealsByLetterUseCaseProtocol = FetchMealsByLetterUseCase()) {
        self.useCase = useCase
    }
    
}

extension MealListViewModel: MealListViewModelProtocol {
    func onLoad(with letter: String) {
        loadingSubject.accept(true)
        useCase.execute(with: letter).subscribe({ [weak self] event in
            guard let self else { return }
            switch event {
            case .next(let models):
                self.displayData = models
                self.dataSubject.onNext(())
            case .error(let error):
                self.dataSubject.onError(error)
            case .completed:
                break
            }
            self.loadingSubject.accept(false)
        }).disposed(by: bag)
    }
}
