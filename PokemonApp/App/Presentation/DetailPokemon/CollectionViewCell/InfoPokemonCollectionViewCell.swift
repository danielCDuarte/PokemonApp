//
//  InfoPokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 12/02/25.
//

import UIKit

final class InfoPokemonCollectionViewCell: GenericCollectionViewCell<InfoDetailObject> {
    
    private struct Constants {
        static let height: String = "Height"
        static let weight: String = "Weight"
    }
    
    private lazy var containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var verticalStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 10
        return stackview
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var measurementLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
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
        setupVerticalStackviewConstraints()
        verticalStackview.addArrangedSubview(nameLabel)
        verticalStackview.addArrangedSubview(imageView)
        setupImageViewConstraints()
        verticalStackview.addArrangedSubview(measurementLabel)
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
    
    private func setupVerticalStackviewConstraints() {
        containterView.addSubview(verticalStackview)
        NSLayoutConstraint.activate([
            verticalStackview.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 10),
            verticalStackview.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10),
            verticalStackview.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -10),
            verticalStackview.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupUI() {
        nameLabel.textColor = .darkGray
        measurementLabel.textColor = .lightGray
    }
    
    override func setup(with item: InfoDetailObject) {
        nameLabel.text = item.name.capitalized
        measurementLabel.text = "\(Constants.height): \(item.height)  \(Constants.weight): \(item.weight)"
        setupImage(with: String(format: DataConstants.Images.getOfficialArtwork, item.id))
    }
    
    private func setupImage(with url: String) {
        guard let urlValidate = URL(string: url) else { return }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                if let image = try await imageView.downloadImage(from: urlValidate) {
                    self.imageView.image = image
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
