//
//  MockSearchMealsUseCase.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import Foundation
import RxSwift
@testable import Meals

final class MockSearchMealsUseCase: SearchMealsUseCaseProtocol {
    
    private let mockType: MockType
    
    init(mockType: MockType) {
        self.mockType = mockType
    }
    
    var searchMealsReturnValue : Observable<[MealModel]>!
    func execute(with query: String) -> Observable<[MealModel]> {
        switch (mockType) {
        case .success:
            return searchMealsReturnValue
        case .fail:
            return Observable.create({ observer in
                observer.onError(BaseErrors.anyError)
                return Disposables.create()
            })
        }
    }
    
}
