//
//  MealsRepository.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import Alamofire
import RxSwift

final class MealsRepository {
    
    private let apiClient: ApiClient
    
    init(with apiClient: ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension MealsRepository: MealsRepositoryProtocol {
    func fetchMeals(letter: String) -> Observable<MealsResponseModel> {
        let path = "/search.php?f=\(letter)"
        return apiClient.request(path, .get, nil, nil).map({ _, data in
            do {
                let meals = try JSONDecoder().decode(MealsResponseModel.self, from: data)
                return meals
            } catch {
                throw BaseErrors.decodeError
            }
        })
    }
    
    func getMeal(by id: String) -> Observable<MealsResponseModel> {
        let path = "/lookup.php?i=\(id)"
        return apiClient.request(path, .get, nil, nil).map({ _, data in
            do {
                let meals = try JSONDecoder().decode(MealsResponseModel.self, from: data)
                return meals
            } catch {
                throw BaseErrors.decodeError
            }
        })
    }
    
    func searchMeals(with query: String) -> Observable<MealsResponseModel> {
        let path = "/search.php?s=\(query)"
        return apiClient.request(path, .get, nil, nil).map({ _, data in
            do {
                let meals = try JSONDecoder().decode(MealsResponseModel.self, from: data)
                return meals
            } catch {
                throw BaseErrors.decodeError
            }
        })
    }
}
