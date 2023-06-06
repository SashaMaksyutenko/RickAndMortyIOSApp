//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 26.05.2023.
//

import UIKit
//Dynamic search option view
//Render results
// Render no results zero state
//Searching API call
///Configurable controller to search
final class RMSearchViewController: UIViewController {
    //Configuraton for search session
    
    struct Config{
        enum `Type`{
            case character
            case episode
            case location
            var title:String{
                switch self{
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }
        let type:`Type`
    }
    private let config:Config
    //MARK: - Init
    init(config:Config){
        self.config=config
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title=config.type.title
        view.backgroundColor = .systemBackground
    }
}
