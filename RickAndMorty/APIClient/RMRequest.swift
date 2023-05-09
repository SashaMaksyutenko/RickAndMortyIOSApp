//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 08.05.2023.
//

import Foundation
/// Object that represents a single API Call
final class RMRequest{
    ///API constants
    private struct Constans{
        static let baseUrl="https://rickandmortyapi.com/api"
    }
    /// Desired endpoint
    private let endpoint:RMEndpoint
    
    /// Path components for API, if any
    private let pathComponents:Set<String>
    
    /// Query components for API, if any
    private let queryParameters:[URLQueryItem]
    /// constructed url for the api request in string format
    private var urlString:String{
        var string=Constans.baseUrl
        string+="/"
        string+=endpoint.rawValue
        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string+="/\($0)"
            })
        }
        if !queryParameters.isEmpty{
            string+="?"
            let argumentString=queryParameters.compactMap({
                guard let value=$0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string+=argumentString
        }
        return string
    }
    
    /// computed & constructed API url
    public var url:URL?{
        return URL(string: urlString)
    }
    
    /// desired http method
    public let httpMethod="GET"
    /// Construct request
        /// - Parameters:
        ///   - endpoint: Target endpoint
        ///   - pathComponents: Collection of Path components
        ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint,pathComponents:Set<String>=[],queryParameters:[URLQueryItem]=[]) {
        self.endpoint = endpoint
        self.pathComponents=pathComponents
        self.queryParameters=queryParameters
    }
}
