//
//  MealDetailViewModel.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift
import RxRelay

final class MealDetailViewModel {
    
    var loadingSubject = BehaviorRelay<Bool>(value: false)
    var dataSubject = PublishSubject<Void>()
    
    var displayData : MealModel?
    
    private let useCase: GetMealByIdUseCaseProtocol
    private let bag = DisposeBag()
    
    private let id: String
    
    init(with id: String, useCase: GetMealByIdUseCaseProtocol = GetMealByIdUseCase()) {
        self.id = id
        self.useCase = useCase
    }
    
}

extension MealDetailViewModel: MealDetailViewModelProtocol {
    func onLoad() {
        loadingSubject.accept(true)
        useCase.execute(with: id).subscribe({ [weak self] event in
            guard let self else { return }
            switch event {
            case .next(let models):
                self.displayData = models.first
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
