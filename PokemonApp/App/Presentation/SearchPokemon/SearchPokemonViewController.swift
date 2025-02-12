//
//  SearchPokemonViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class SearchPokemonViewController: BaseViewController {
    
    weak var coordinator: SearchPokemonCoordinator?
    
    private var pokemons: [PokemonObject] = []
    
    private struct Constants {
        static let backgroundColor: UIColor = .white
        static let navigationBarLightGray: UIColor = .lightGray
        static let title: String = "Pokemons"
        static let searchPlaceHolder: String = "Search Pokemon"
    }
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(frame: .zero, layout: .list)
        collectionView.setMinimumLineSpacing(10)
        collectionView.setMinimumInteritemSpacing(10)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var ownerPresenter: SearchPokemonPresenterType! {
        return presenter as? SearchPokemonPresenterType
    }
    
    override func viewDidLoad() {
        title = Constants.title
        setupConstraintsCollectionView()
        setupUI()
        setupSearchBar()
        ownerPresenter?.bind(withView: self)
        super.viewDidLoad()
    }
    
    private func setupConstraintsCollectionView() {
        view.addSubview(collectionView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15)
        ])
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(cellWithClass: PokemonCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor
        searchBar.placeholder = Constants.searchPlaceHolder
    }
}

extension SearchPokemonViewController: SearchPokemonViewType {
    
    func showSection(_ section: [PokemonObject]) {
        pokemons = section
        collectionView.reloadData()
    }
    
    func pushToPokemon(_ pokemon: PokemonObject) {
        coordinator?.pushDetail(pokemon)
    }
}


extension SearchPokemonViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonCollectionViewCell.self), for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = pokemons[indexPath.row]
        cell.setup(with: pokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ownerPresenter.didSelectPokemonAt(indexPath: indexPath)
    }
   
}

extension SearchPokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ownerPresenter.didSearchPokemon(searchText.lowercased())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        ownerPresenter.didsearchBarCancelButton()
    }
}
