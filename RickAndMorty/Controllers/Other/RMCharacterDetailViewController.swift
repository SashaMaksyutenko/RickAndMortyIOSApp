//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Sasha Maksyutenko on 15.05.2023.
//

import UIKit
/// controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel:RMCharacterDetailViewViewModel
    init(viewModel: RMCharacterDetailViewViewModel){
        self.viewModel=viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder:NSCoder) {
        fatalError("Unsupported")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title=viewModel.title
        
    }
}
