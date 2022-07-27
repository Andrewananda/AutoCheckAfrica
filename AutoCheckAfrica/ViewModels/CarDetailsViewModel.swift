//
//  CarDetailsViewModel.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import Foundation
import RxSwift
import RxRelay

class CarDetailsViewModel {
    fileprivate var apiService : NetworkService
    var carDetailsLiveData = PublishRelay<CarDetailResponse>()
    var showLoading = BehaviorRelay<Bool>(value: true)
    
    init() {
            self.apiService = NetworkService()
        }
    
    func fetchCarDetails(id: String) {
        showLoading.accept(true)
        apiService.fetchData(url: "car/\(id)", method: .get, params: nil) { [weak self] (response: Swift.Result<CarDetailResponse, Errors>) in
            switch response {
            case .success(let res):
                self?.carDetailsLiveData.accept(res)
                self?.showLoading.accept(false)
            case .failure(let error) :
                self?.showLoading.accept(false)
                print("Error \(error)")
            }
        }
    }
    
}
