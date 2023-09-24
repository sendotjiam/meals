//
//  MockMealsRepository.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import Foundation
import RxSwift
@testable import Meals

final class MockMealsRepository : MealsRepositoryProtocol {
    
    var fetchMealsByLetterReturnValue: Observable<MealsResponseModel>!
    func fetchMeals(letter: String) -> Observable<MealsResponseModel> {
        fetchMealsByLetterReturnValue
    }
    
    var getMealByIdReturnValue: Observable<MealsResponseModel>!
    func getMeal(by id: String) -> Observable<MealsResponseModel> {
        getMealByIdReturnValue
    }
    
    var searchMealsReturnValue: Observable<MealsResponseModel>!
    func searchMeals(with query: String) -> Observable<MealsResponseModel> {
        searchMealsReturnValue
    }
}
