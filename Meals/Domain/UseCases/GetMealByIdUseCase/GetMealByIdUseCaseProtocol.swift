//
//  GetMealByIdUseCaseProtocol.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

protocol GetMealByIdUseCaseProtocol {
    func execute(with id: String) -> Observable<[MealModel]>
}
