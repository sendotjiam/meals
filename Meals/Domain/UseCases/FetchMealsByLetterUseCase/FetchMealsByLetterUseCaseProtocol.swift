//
//  FetchMealsByLetterUseCaseProtocol.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift

protocol FetchMealsByLetterUseCaseProtocol {
    func execute(with letter: String) -> Observable<[MealModel]>
}
