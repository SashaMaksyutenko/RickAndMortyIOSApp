//
//  RMGetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 04.06.2023.
//

import Foundation
struct RMGetAllLocationsResponse:Codable{
    struct Info:Codable{
        let count:Int
        let pages:Int
        let next:String?
        let prev:String?
    }
    let info:Info
    let results:[RMLocation]
}
