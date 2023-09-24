//
//  MockApiClient.swift
//  MealsTests
//
//  Created by Sendo Tjiam on 23/09/23.
//

import Foundation
import RxSwift
import Alamofire
@testable import Meals

final class MockApiClient: ApiClient {
    
    var data : Data?
    
    func request(_ path: String, _ method: HTTPMethod, _ parameters: Parameters?, _ headers: HTTPHeaders?) -> Observable<(HTTPURLResponse, Data)> {
        Observable.create({ [weak self] observer in
            guard let self else {
                observer.onError(BaseErrors.anyError)
                return Disposables.create()
            }
            guard let data = self.data else {
                observer.onError(BaseErrors.emptyDataError)
                return Disposables.create()
            }
            observer.onNext((HTTPURLResponse(), data))
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
