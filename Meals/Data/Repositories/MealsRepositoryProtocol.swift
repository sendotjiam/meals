//
//  MealsRepositoryProtoco.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

protocol MealsRepositoryProtocol {
    func fetchMeals(letter: String) -> Observable<MealsResponseModel>
    func getMeal(by id: String) -> Observable<MealsResponseModel>
    func searchMeals(with query: String) -> Observable<MealsResponseModel>
}
