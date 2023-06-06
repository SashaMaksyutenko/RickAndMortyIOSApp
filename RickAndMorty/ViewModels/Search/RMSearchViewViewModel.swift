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
    init(config:RMSearchViewController.Config){
        self.config=config
    }
}
