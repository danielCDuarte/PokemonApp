//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class DetailPokemonViewController: BaseViewController {
    private var ownerPresenter: DetailPokemonPresenterType! {
        return presenter as? DetailPokemonPresenterType
    }
    
    override func viewDidLoad() {
//        self.title = Constants.title
//        setupConstraints()
//        setupUI()
        ownerPresenter?.bind(withView: self)
        super.viewDidLoad()
    }
}

extension DetailPokemonViewController: DetailPokemonViewType {
    func showCharacter(_ detail: DetailObject) {
    
    }
}
