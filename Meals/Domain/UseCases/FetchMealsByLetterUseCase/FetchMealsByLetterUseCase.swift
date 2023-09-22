//
//  FetchMealsByLetter.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

final class FetchMealsByLetterUseCase : FetchMealsByLetterUseCaseProtocol {
    private let repository: MealsRepositoryProtocol
    
    init(repository: MealsRepositoryProtocol = MealsRepository()) {
        self.repository = repository
    }
    
    func execute(with letter: String) -> Observable<[MealModel]>{
        return repository.fetchMeals(letter: letter).map({ responseModel -> [MealModel] in
            return responseModel.meals?.map({ $0.toDomain() }) ?? []
        })
    }
}
