//
//  NetworkService.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 27/07/2022.
//

import Foundation
import Alamofire

class NetworkService {
    func fetchData<T: Codable>(url: String, method: HTTPMethod, params: [String: Any]?, completion: @escaping (Result<T, Errors>) -> Void) {
        
        let endpoint = "https://api-prod.autochek.africa/v1/inventory/\(url)"
        
        AF.request(endpoint, method: method, parameters: params, encoding: URLEncoding.default, headers: HTTPHeaders.default)
            .validate(statusCode: 200..<300).responseJSON { response in
                if let httpUrlResponse = response.response, 200..<300 ~= httpUrlResponse.statusCode {
                    guard let processData = response.data else {
                        completion(.failure(Errors.emptyResponse))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.dataDecodingStrategy = .base64
                        completion(.success(try decoder.decode(T.self, from: processData)))
                    }  catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                } else {
                    print("ErrorCause")
                    completion(.failure(Errors.emptyResponse))
                }
            }
    }
}

public enum Errors : Error {
    case emptyResponse
    case custom(Int, String)
    case apiError(String)
}
