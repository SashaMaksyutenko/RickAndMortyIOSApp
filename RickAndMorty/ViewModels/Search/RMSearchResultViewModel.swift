//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 22.06.2023.
//

import Foundation
enum RMSearchResultViewModel{
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
