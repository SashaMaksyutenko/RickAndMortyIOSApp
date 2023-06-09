//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 06.06.2023.
//

import Foundation
//Responsibilities
// - show search results
// - show no results view
// kick off API requests
final class RMSearchViewViewModel{
    let config:RMSearchViewController.Config
    private var optionMap:[RMSearchInputViewViewModel.DynamicOption:String]=[:]
    private var seachText=""
    private var optionMapUpdateBlock:(((RMSearchInputViewViewModel.DynamicOption,String))->Void)?
    //MARK: - Init
    init(config:RMSearchViewController.Config){
        self.config=config
    }
    //MARK: - PUBLIC
    public func exetuteSearch(){
        // create request based on filters
        // send API call
        // notify view of results, no results or error
        
    }
    public func set(value:String, for option:RMSearchInputViewViewModel.DynamicOption){
        optionMap[option]=value
        let tuple=(option,value)
        optionMapUpdateBlock?(tuple)
        
    }
    public func registerOptionChangeBlock(_ block:@escaping((RMSearchInputViewViewModel.DynamicOption,String))->Void){
        
        self.optionMapUpdateBlock=block
    }
    }

