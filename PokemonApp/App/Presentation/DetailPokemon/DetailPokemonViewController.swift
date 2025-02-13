//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

enum Section: Int, CaseIterable {
    case header
    case abilities
    case stats
    
    var title: String? {
        switch self {
        case .header:
            return nil
        case .abilities:
            return "Abilitites"
        case .stats: 
            return "Stats"
        }
    }
}

enum PokemonDetailItem: Hashable, Sendable {
    case header(InfoDetailObject)
    case ability(AbilityObject)
    case stat(StatObject)
}

class DetailPokemonViewController: BaseViewController {
    private var detailPokemon: DetailObject?
    private var dataSource: UICollectionViewDiffableDataSource<Section, PokemonDetailItem>?
    
    private var ownerPresenter: DetailPokemonPresenterType! {
        return presenter as? DetailPokemonPresenterType
    }
    
    private struct Constants {
        static let title: String = "Detail Pokemon"
        static let backgroundColor: UIColor = .white
    }
    
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(frame: .zero, layout: .list)
        collectionView.setMinimumLineSpacing(0)
        collectionView.setMinimumInteritemSpacing(0)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        title = Constants.title
        setupConstraints()
        setupUI()
        setupCollectionView()
        configureDataSource()
        ownerPresenter?.bind(withView: self)
        super.viewDidLoad()
    }
    
    private func setupConstraints() {
        setupContraintsCollectionView()
    }
    
    private func setupContraintsCollectionView() {
        view.addSubview(collectionView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(cellWithClass: InfoPokemonCollectionViewCell.self)
        collectionView.register(cellWithClass: ItemCollectionViewCell.self)
        collectionView.register(
            SectionHeaderCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
        )
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item in
                return self?.cell(for: indexPath, item: item, collectionView: collectionView)
            }
        )
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return self?.supplementaryView(for: indexPath, kind: kind, collectionView: collectionView)
        }
    }
    
    private func cell(for indexPath: IndexPath, item: PokemonDetailItem, collectionView: UICollectionView) -> UICollectionViewCell? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        
        switch section {
        case .header:
            guard case let .header(info) = item,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: InfoPokemonCollectionViewCell.self),
                    for: indexPath
                  ) as? InfoPokemonCollectionViewCell else { return nil }
            cell.setup(with: info)
            return cell
            
        case .abilities:
            guard case let .ability(ability) = item,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: ItemCollectionViewCell.self),
                    for: indexPath
                  ) as? ItemCollectionViewCell else { return nil }
            cell.setup(with: .init(
                title: ability.ability.name)
            )
            return cell
            
        case .stats:
            guard case let .stat(stat) = item,
                  let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: ItemCollectionViewCell.self),
                    for: indexPath
                  ) as? ItemCollectionViewCell else { return nil }
            cell.setup(with: .init(
                title: stat.stat.name,
                value: "\(stat.baseStat)")
            )
            return cell
        }
    }
    
    private func supplementaryView(
        for indexPath: IndexPath,
        kind: String,
        collectionView: UICollectionView
    ) -> UICollectionReusableView? {
        guard kind == UICollectionView.elementKindSectionHeader,
              let section = Section(rawValue: indexPath.section),
              let title = section.title else { return nil }
        let headerView = collectionView.dequeueReusableHeaderFooterView(
            kind: kind,
            withClass: SectionHeaderCollectionViewCell.self,
            for: indexPath
        )
        headerView.setup(with: title)
        return headerView
    }
    
}

extension DetailPokemonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let title = Section(rawValue: section)?.title else { return .zero }
        return CGSize(width: collectionView.frame.width, height: title.isEmpty ? 0 : 40)
    }
}

extension DetailPokemonViewController: DetailPokemonViewType {
    func showDetail(_ detail: DetailObject) {
        detailPokemon = detail
        var snapshot = NSDiffableDataSourceSnapshot<Section, PokemonDetailItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.header(detail.info)], toSection: .header)
        snapshot.appendItems(detail.abilities.map { .ability($0) }, toSection: .abilities)
        snapshot.appendItems(detail.stats.map { .stat($0) }, toSection: .stats)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
