//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 08.05.2023.
//

import Foundation
/// Primary API Service object to get Rick and Morty data
final class RMService{
    /// Shared Singleton instance
    static let shared=RMService()
    private let cacheManager=RMAPICacheManager()
    /// Privatized constructor
    private init () {}
    enum RMServiceError:Error{
        case failedToCreateRequest
        case failedtoGetData
    }
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: request instance
    ///   - type: the type of the object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type:T.Type,
        completion: @escaping(Result<T,Error>
        ) -> Void){
        if let cachedData=cacheManager.cachedResponse(for: request.endpoint, url:request.url){
            do{
                let result=try JSONDecoder().decode(type.self,from:cachedData)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
            
            return
        }
        guard let urlRequest=self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task=URLSession.shared.dataTask(with: urlRequest){[weak self]
            data,_,error in guard let data=data, error==nil else{
                completion(.failure(error ?? RMServiceError.failedtoGetData))
                return
            }
            //Decode response
            do{
                let result=try JSONDecoder().decode(type.self,from:data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    private func request(from rmRequest:RMRequest)->URLRequest?{
        guard let url=rmRequest.url else {
            return nil
        }
        var request=URLRequest(url:url)
        request.httpMethod=rmRequest.httpMethod
        return request
    }
}
