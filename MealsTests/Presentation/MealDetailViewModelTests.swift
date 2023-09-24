//
//  MealDetailViewModelTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Meals

final class MealDetailViewModelTests: XCTestCase {
    
    private var sut: MealDetailViewModelProtocol!
    private var useCase: MockGetMealByIdUseCase!
    private let bag = DisposeBag()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func test_OnLoad_Succeed() {
        useCase = MockGetMealByIdUseCase(mockType: .success)
        sut = MealDetailViewModel(with: "52768", useCase: useCase)
        let meal = MockData.generateMealsModel()
        useCase.getMealByIdReturnValue = .just(meal)
        sut.onLoad()
        let result = sut.displayData
        XCTAssertEqual(result, meal.first)
    }
    
    func test_OnLoad_Failed() {
        useCase = MockGetMealByIdUseCase(mockType: .fail)
        sut = MealDetailViewModel(with: "52768", useCase: useCase)
        sut.dataSubject.subscribe(onError: { error in
            XCTAssertEqual(error as! BaseErrors, BaseErrors.anyError)
        }).disposed(by: bag)
        sut.onLoad()
    }
}
