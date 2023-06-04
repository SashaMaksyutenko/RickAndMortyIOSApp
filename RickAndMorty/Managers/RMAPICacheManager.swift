//
//  RMCacheManager.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 25.05.2023.
//

import Foundation
//Manages in memory session scoped API caches
final class RMAPICacheManager{
    private var cacheDictionary:[RMEndpoint:NSCache<NSString,NSData>]=[:]
    //API URL:Data
    private var cache=NSCache<NSString,NSData>()
    init(){
        setupCache()
    }
    //MARK: - PUBLIC
    public func cachedResponse(for endpoint:RMEndpoint,url:URL?)->Data?{
        guard let targetCache=cacheDictionary[endpoint], let url=url else {return nil}
        let key=url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    public func setCache(for endpoint:RMEndpoint,url:URL?,data:Data){
        guard let targetCache=cacheDictionary[endpoint], let url=url else {return}
        let key=url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    //MARK: - private
    private func setupCache(){
        RMEndpoint.allCases.forEach({endpoint in cacheDictionary[endpoint] = NSCache<NSString,NSData>()
        })
    }
}
