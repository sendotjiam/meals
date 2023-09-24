//
//  GetMealByIdUseCaseTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import Foundation
import RxSwift
import RxBlocking
@testable import Meals


final class GetMealByIdUseCaseTests: XCTestCase {

    private var useCase: GetMealByIdUseCaseProtocol!
    private var repository: MockMealsRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockMealsRepository()
        useCase = GetMealByIdUseCase(repository: repository)
    }
    
    func test_GetMealById() {
        let mealsResponseModel = MockData.generateMealsResponseModel()
        let mealsModel = MockData.generateMealsModel()
        repository.getMealByIdReturnValue = .just(mealsResponseModel)
        let result = useCase.execute(with: "52768")
        XCTAssertEqual(try result.toBlocking().first(), mealsModel)
    }

}
