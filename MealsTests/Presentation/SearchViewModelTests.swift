//
//  SearchViewModelTests.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Meals

final class SearchViewModelTests: XCTestCase {
    
    private var sut: SearchViewModelProtocol!
    private var useCase: MockSearchMealsUseCase!
    private let bag = DisposeBag()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func test_OnSearch_Succeed() {
        useCase = MockSearchMealsUseCase(mockType: .success)
        sut = SearchViewModel(with: useCase)
        let meals = MockData.generateMealsModel()
        useCase.searchMealsReturnValue = .just(meals)
        sut.onSearch(keyword: "Apple Frangipan Tart")
        let result = sut.displayData
        XCTAssertEqual(result, meals)
    }
    
    func test_OnSearch_Failed() {
        useCase = MockSearchMealsUseCase(mockType: .fail)
        sut = SearchViewModel(with: useCase)
        sut.dataSubject.subscribe(onError: { error in
            XCTAssertEqual(error as! BaseErrors, BaseErrors.anyError)
        }).disposed(by: bag)
        sut.onSearch(keyword: "Apple Frangipan Tart")
    }
}
