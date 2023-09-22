//
//  SearchMealsUseCase.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

final class SearchMealsUseCase : SearchMealsUseCaseProtocol {
    private let repository: MealsRepositoryProtocol
    
    init(repository: MealsRepositoryProtocol = MealsRepository()) {
        self.repository = repository
    }
    
    func execute(with query: String) -> Observable<[MealModel]>{
        return repository.searchMeals(with: query).map({ responseModel -> [MealModel] in
            return responseModel.meals?.map({ $0.toDomain() }) ?? []
        })
    }
}
