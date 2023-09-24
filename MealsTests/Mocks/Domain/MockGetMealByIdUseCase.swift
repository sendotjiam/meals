//
//  MockGetMealByIdUseCase.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import Foundation
import RxSwift
@testable import Meals

final class MockGetMealByIdUseCase: GetMealByIdUseCaseProtocol {
    
    private let mockType: MockType
    
    init(mockType: MockType) {
        self.mockType = mockType
    }
    
    var getMealByIdReturnValue : Observable<[MealModel]>!
    func execute(with id: String) -> Observable<[MealModel]> {
        switch (mockType) {
        case .success:
            return getMealByIdReturnValue
        case .fail:
            return Observable.create({ observer in
                observer.onError(BaseErrors.anyError)
                return Disposables.create()
            })
        }
    }
    
}
