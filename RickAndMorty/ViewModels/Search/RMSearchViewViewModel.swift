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
    private var searchText=""
    private var optionMapUpdateBlock:(((RMSearchInputViewViewModel.DynamicOption,String))->Void)?
    private var searchResultHandler:((RMSearchResultViewModel)->Void)?
    //MARK: - Init
    init(config:RMSearchViewController.Config){
        self.config=config
    }
    //MARK: - PUBLIC
    public func registerSearchResultHandler(_ block:@escaping(RMSearchResultViewModel)->Void){
        self.searchResultHandler=block
    }
    public func exetuteSearch(){
        // test search text
        // build arguments
        var queryParams:[URLQueryItem]=[URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        // Add options
        queryParams.append(contentsOf:  optionMap.enumerated().compactMap({_, element in
            let key:RMSearchInputViewViewModel.DynamicOption=element.key
            let value:String=element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        // create requests
        let request=RMRequest(endpoint: config.type.endpoint,queryParameters:queryParams)
        
//            switch config.type.endpoint{
//            case .character:
//                RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { result in
//                    // notify view of results, no results or error
//                    switch result{
//                    case .success(let model):
//                        // episodes, characters - collectionView; location - tableView
//                        print ("Search results found: \(model.results.count)")
//                    case .failure:
//                        print("failed to get results")
//                        break
//                    }
//                }
//            case .episode:
//                RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { result in
//                    // notify view of results, no results or error
//                    switch result{
//                    case .success(let model):
//                        // episodes, characters - collectionView; location - tableView
//                        print ("Search results found: \(model.results.count)")
//                    case .failure:
//                        print("failed to get results")
//                        break
//                    }
//                }
//            case .location:
//            }
        switch config.type.endpoint{
        case .character:
            makeSearchAPICall(RMGetAllCharactersResponse.self, request: request)
        case .episode:
            makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
        case .location:
            makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        }
        }
    private func makeSearchAPICall<T:Codable>(_ type:T.Type, request:RMRequest){
        RMService.shared.execute(request, expecting: type) {[weak self] result in
            // notify view of results, no results or error
            switch result{
            case .success(let model):
                self?.processSearchResults(model:model)
            case .failure:
                print("failed to get results")
                break
            }
        }
    }
    private func processSearchResults(model:Codable){
        var resultsVM:RMSearchResultViewModel?
        if let characterResults=model as? RMGetAllCharactersResponse{
            resultsVM = .characters(characterResults.results.compactMap({
                return RMCharacterCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
            }))
        }
        else if let episodesResults=model as? RMGetAllEpisodesResponse{
            resultsVM = .episodes(episodesResults.results.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string:$0.url))
            }))
        }
        else if let locationsResults=model as? RMGetAllLocationsResponse{
            resultsVM = .locations(locationsResults.results.compactMap({
                return RMLocationTableViewCellViewModel(location: $0)
            }))
        }
        if let results=resultsVM{
            self.searchResultHandler?(results)
        }else
        {
            //fallBack error
        }
    }
    public func set(query text:String){
        self.searchText=text
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

