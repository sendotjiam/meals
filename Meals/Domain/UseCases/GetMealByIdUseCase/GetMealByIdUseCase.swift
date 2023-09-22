//
//  GetMealByIdUseCase.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

final class GetMealByIdUseCase : GetMealByIdUseCaseProtocol{
    private let repository: MealsRepositoryProtocol
    
    init(repository: MealsRepositoryProtocol = MealsRepository()) {
        self.repository = repository
    }
    
    func execute(with id: String) -> Observable<[MealModel]>{
        return repository.getMeal(by: id).map({ responseModel -> [MealModel] in
            return responseModel.meals?.map({ $0.toDomain() }) ?? []
        })
    }
}
