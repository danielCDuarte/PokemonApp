//
//  ItemCollectionViewCell.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 12/02/25.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var horizontalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        return stackview
    }()
    
    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var valueLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupHorizontalStackviewConstraints()
        horizontalStackview.addArrangedSubview(titleLabel)
        horizontalStackview.addArrangedSubview(valueLabel)
    }
    
    private func setupContainerViewConstraints() {
        contentView.addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupHorizontalStackviewConstraints() {
        containterView.addSubview(horizontalStackview)
        NSLayoutConstraint.activate([
            horizontalStackview.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 10),
            horizontalStackview.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10),
            horizontalStackview.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -10),
            horizontalStackview.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupUI() {
        titleLabel.textColor = .lightGray
        valueLabel.textColor = .lightGray
    }

    func setup(with title: String, value: String? = nil) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
