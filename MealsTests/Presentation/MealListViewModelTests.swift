//
//  MealListViewModelTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Meals

final class MealListViewModelTests: XCTestCase {
    
    private var sut: MealListViewModelProtocol!
    private var useCase: MockFetchMealsByLetterUseCase!
    private let bag = DisposeBag()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func test_OnViewDidLoad_Succeed() {
        useCase = MockFetchMealsByLetterUseCase(mockType: .success)
        sut = MealListViewModel(with: useCase)
        let meals = MockData.generateMealsModel()
        useCase.fetchMealsByLetterReturnValue = .just(meals)
        sut.onLoad(with: "A")
        let result = sut.displayData
        XCTAssertEqual(result, meals)
    }
    
    func test_OnViewDidLoad_Failed() {
        useCase = MockFetchMealsByLetterUseCase(mockType: .fail)
        sut = MealListViewModel(with: useCase)
        sut.dataSubject.subscribe(onError: { error in
            XCTAssertEqual(error as! BaseErrors, BaseErrors.anyError)
        }).disposed(by: bag)
        sut.onLoad(with: "A")
    }
    
}
