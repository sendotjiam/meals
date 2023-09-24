//
//  SearchMealsUseCaseTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import Foundation
import RxSwift
import RxBlocking
@testable import Meals

final class SearchMealsUseCaseTests: XCTestCase {

    private var useCase: SearchMealsUseCaseProtocol!
    private var repository: MockMealsRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = MockMealsRepository()
        useCase = SearchMealsUseCase(repository: repository)
    }
    
    func test_SearchMeals() {
        let mealsResponseModel = MockData.generateMealsResponseModel()
        let mealsModel = MockData.generateMealsModel()
        repository.searchMealsReturnValue = .just(mealsResponseModel)
        let result = useCase.execute(with: "Apple Frangipan Tart")
        XCTAssertEqual(try result.toBlocking().first(), mealsModel)
    }

}
