//
//  CarViewModel.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import Foundation
import RxSwift
import RxRelay

class CarViewModel {
    fileprivate var apiService : NetworkService
    var carsLiveData = PublishRelay<[CarsModel]>()
    var popularCarsLiveData = PublishRelay<[MakeList]>()
    var showLoading = BehaviorRelay<Bool>(value: true)
    var totalPages = BehaviorRelay<Int>(value: 50)
    
    init() {
            self.apiService = NetworkService()
        }
    
    func fetchCars() {
        showLoading.accept(true)
        apiService.fetchData(url: "car/search", method: .get, params: nil) { [weak self] (response: Swift.Result<CarsResponse, Errors>) in
            switch response {
            case .success(let res):
                self?.totalPages.accept(res.pagination.total)
                self?.carsLiveData.accept(res.result)
                self?.showLoading.accept(false)
            case .failure(let error) :
                print("Error \(error)")
                self?.showLoading.accept(false)
            }
        }
    }
    
    func filterCars(query: String, size: Int) {
        let q = query.replacingOccurrences(of: " ", with: "%20")
        showLoading.accept(true)
        apiService.fetchData(url: "car/search?query=\(q)&pageSize=\(size)", method: .get, params: nil) { [weak self] (response: Swift.Result<CarsResponse, Errors>) in
            switch response {
            case .success(let res):
                self?.totalPages.accept(res.pagination.total)
                self?.carsLiveData.accept(res.result)
                self?.showLoading.accept(false)
            case .failure(let error) :
                self?.showLoading.accept(false)
                print("Error \(error)")
            }
        }
    }
    
    func fetchPopularCars() {
        showLoading.accept(true)
        apiService.fetchData(url: "make?popular=true", method: .get, params: nil) { [weak self] (response: Swift.Result<PopularCarsModel, Errors>) in
            switch response {
            case .success(let res):
                self?.totalPages.accept(res.pagination.total)
                self?.popularCarsLiveData.accept(res.makeList)
                self?.showLoading.accept(false)
            case .failure(let error) :
                print("Error \(error)")
                self?.showLoading.accept(false)
            }
        }
    }
    
    func updateList(query: String?, size: Int) {
        let q : String
        let url : String
        if let query = query {
            q = query.replacingOccurrences(of: " ", with: "%20")
            url = "car/search?query=\(q)&pageSize=\(size)"
        }else {
            url = "car/search?pageSize=\(size)"
        }
        showLoading.accept(true)
        
        apiService.fetchData(url: url, method: .get, params: nil) { [weak self] (response: Swift.Result<CarsResponse, Errors>) in
            switch response {
            case .success(let res):
                self?.totalPages.accept(res.pagination.total)
                self?.carsLiveData.accept(res.result)
                self?.showLoading.accept(false)
            case .failure(let error) :
                print("Error \(error)")
                self?.showLoading.accept(false)
            }
        }
    }
}
