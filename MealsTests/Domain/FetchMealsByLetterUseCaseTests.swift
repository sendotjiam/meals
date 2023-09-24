//
//  FetchMealsByLetterUseCaseTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import Foundation
import RxSwift
import RxBlocking
@testable import Meals


final class FetchMealsByLetterUseCaseTests: XCTestCase {

    private var useCase: FetchMealsByLetterUseCaseProtocol!
    private var repository: MockMealsRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockMealsRepository()
        useCase = FetchMealsByLetterUseCase(repository: repository)
    }
    
    func test_FetchMealsByLetter() {
        let mealsResponseModel = MockData.generateMealsResponseModel()
        let mealsModel = MockData.generateMealsModel()
        repository.fetchMealsByLetterReturnValue = .just(mealsResponseModel)
        let result = useCase.execute(with: "A")
        XCTAssertEqual(try result.toBlocking().first(), mealsModel)
    }

}
