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
     let endpoint:RMEndpoint
    /// Path components for API, if any
    private let pathComponents:[String]
    
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
    public init(endpoint: RMEndpoint,pathComponents:[String]=[],queryParameters:[URLQueryItem]=[]) {
        self.endpoint = endpoint
        self.pathComponents=pathComponents
        self.queryParameters=queryParameters
    }
    /// Attempt to create request
    /// - Parameter url: URl to parse
    convenience init?(url:URL){
        let string=url.absoluteString
        if !string .contains(Constans.baseUrl){
            return nil
        }
        let trimmed=string.replacingOccurrences(of: Constans.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components=trimmed.components(separatedBy: "/")
            
           
            if !components.isEmpty{
                let endPointString=components[0]//EndPoint
                var pathComponents:[String]=[]
                if components.count>1{
                    pathComponents=components
                    pathComponents.removeFirst()
                }
                if let rmEndPoint=RMEndpoint(rawValue: endPointString){
                    self.init(endpoint: rmEndPoint,pathComponents: pathComponents)
                    return
                }
            }
        }
        else if trimmed.contains("?"){
            let components=trimmed.components(separatedBy: "?")
            if !components.isEmpty,components.count>=2{
                let endPointString=components[0]
                let queryItemsString=components[1]
                let queryItems:[URLQueryItem]=queryItemsString.components(separatedBy: "&").compactMap(
                {
                    guard $0.contains("=")else{
                        return nil
                    }
                    let parts=$0.components(separatedBy:"=")
                    return URLQueryItem(name:parts[0], value:parts[1])})
                if let rmEndPoint=RMEndpoint(rawValue: endPointString){
                    self.init(endpoint: rmEndPoint,queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}
extension RMRequest{
    static let listCharactersRequests=RMRequest(endpoint: .character)
    static let listEpisodesRequest=RMRequest(endpoint: .episode)
    static let listLocationsRequest=RMRequest(endpoint: .location)

}
