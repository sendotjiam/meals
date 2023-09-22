//
//  SearchMealsUseCaseProtocol.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

protocol SearchMealsUseCaseProtocol {
    func execute(with query: String) -> Observable<[MealModel]>
}
