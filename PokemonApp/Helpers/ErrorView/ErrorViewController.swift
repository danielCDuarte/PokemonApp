//
//  ErrorViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class ErrorViewController: UIViewController {
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private lazy var errorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let error: NetworkError
    private let retryAction: (() -> Void)?
    
    init(error: NetworkError, retryAction: (() -> Void)? = nil) {
        self.error = error
        self.retryAction = retryAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        configureErrorDetails()
    }
    
    private func setupView() {
        setupConstraintsErrorImageView()
        setupConstraintsErrorTitleLabel()
        setupConstraintsErrorDescriptionLabel()
        setupConstraintsActionButton()
    }
    
    private func setupConstraintsErrorImageView() {
        view.addSubview(errorImageView)
        NSLayoutConstraint.activate([
            errorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            errorImageView.widthAnchor.constraint(equalToConstant: 150),
            errorImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupConstraintsErrorTitleLabel() {
        view.addSubview(errorTitleLabel)
        NSLayoutConstraint.activate([
            errorTitleLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 20),
            errorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupConstraintsErrorDescriptionLabel() {
        view.addSubview(errorDescriptionLabel)
        NSLayoutConstraint.activate([
            errorDescriptionLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 10),
            errorDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupConstraintsActionButton() {
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: errorDescriptionLabel.bottomAnchor, constant: 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 150),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    private func configureErrorDetails() {
        switch error {
        case .badURL:
            setupErrorView(
                title: "Invalid URL",
                description: "The provided URL is not valid. Please verify the address.",
                image: UIImage(systemName: "exclamationmark.triangle"),
                buttonTitle: "Try Again"
            )
        
        case .apiError(let code, let errorMessage):
            setupErrorView(
                title: "API Error",
                description: "Error Code: \(code)\n\(errorMessage)",
                image: UIImage(systemName: "network"),
                buttonTitle: "Retry"
            )
        
        case .invalidJSON(let errorMessage):
            setupErrorView(
                title: "Format Error",
                description: "Unable to process the response: \(errorMessage)",
                image: UIImage(systemName: "doc.text.magnifyingglass"),
                buttonTitle: "Retry"
            )
        
        case .unauthorized(let code, let errorMessage):
            setupErrorView(
                title: "Unauthorized",
                description: "Code: \(code)\n\(errorMessage)",
                image: UIImage(systemName: "lock"),
                buttonTitle: "Login"
            )
        
        case .badRequest(let code, let errorMessage):
            setupErrorView(
                title: "Bad Request",
                description: "Code: \(code)\n\(errorMessage)",
                image: UIImage(systemName: "xmark.octagon"),
                buttonTitle: "Verify"
            )
        
        case .noResponse(let errorMessage):
            setupErrorView(
                title: "No Response",
                description: errorMessage,
                image: UIImage(systemName: "wifi.slash"),
                buttonTitle: "Retry"
            )
        
        case .unableToParseData(let errorMessage):
            setupErrorView(
                title: "Parsing Error",
                description: errorMessage,
                image: UIImage(systemName: "doc.text.magnifyingglass"),
                buttonTitle: "Retry"
            )
        
        case .unknown(let code, let errorMessage):
            setupErrorView(
                title: "Unknown Error",
                description: "Code: \(code)\n\(errorMessage)",
                image: UIImage(systemName: "questionmark.circle"),
                buttonTitle: "Try Again"
            )
        
        case .invalidUrl:
            setupErrorView(
                title: "Invalid URL",
                description: "The provided address is incorrect.",
                image: UIImage(systemName: "link"),
                buttonTitle: "Verify"
            )
        
        case .serverError:
            setupErrorView(
                title: "Server Error",
                description: "There was a problem with the server. Please try again later.",
                image: UIImage(systemName: "server.rack"),
                buttonTitle: "Retry"
            )
        
        case .emptyJson:
            setupErrorView(
                title: "Empty Response",
                description: "The server returned a response without content.",
                image: UIImage(systemName: "doc.text"),
                buttonTitle: "Try Again"
            )
        }
    }
    
    private func setupErrorView(
        title: String,
        description: String,
        image: UIImage?,
        buttonTitle: String
    ) {
        errorTitleLabel.text = title
        errorDescriptionLabel.text = description
        errorImageView.image = image ?? UIImage(systemName: "exclamationmark.triangle")
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    @objc private func actionButtonTapped() {
        retryAction?()
        dismiss(animated: true, completion: nil)
    }
}
