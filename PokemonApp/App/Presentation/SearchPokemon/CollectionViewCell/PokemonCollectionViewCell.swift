//
//  PokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 12/02/25.
//

import UIKit
import Kingfisher

final class PokemonCollectionViewCell: UICollectionViewCell {
    
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
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
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
        containterView.addSubview(horizontalStackview)
        setupHorizontalStackviewConstraints()
        horizontalStackview.addArrangedSubview(iconImageView)
        setupIconImageViewContraints()
        horizontalStackview.addArrangedSubview(nameLabel)
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
        NSLayoutConstraint.activate([
            horizontalStackview.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 10),
            horizontalStackview.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10),
            horizontalStackview.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -10),
            horizontalStackview.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupIconImageViewContraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupUI() {
        containterView.setShadow(
            opacity: 0.1,
            offset: CGSize(width: 0, height: 2),
            radius: 12,
            color: UIColor.black.cgColor
        )
        nameLabel.textColor = .darkGray
    }
    
    func setup(with pokemon: PokemonObject) {
        nameLabel.text = pokemon.name.capitalized
        setupImage(with: String(format: DataConstants.Images.getSprite, pokemon.id))
    }
    
    private func setupImage(with url: String) {
        guard let urlValidate = URL(string: url) else { return }
        iconImageView.kf.indicatorType = .activity
        let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))
        
        iconImageView.kf.setImage(
            with: .network(urlValidate),
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.kf.cancelDownloadTask()
        iconImageView.image = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
