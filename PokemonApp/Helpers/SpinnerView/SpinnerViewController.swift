//
//  SpinnerViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class SpinnerViewController: UIViewController {
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func loadView() {
        super.loadView()
        setupContrantsSpinner()
        setupUI()
    }
    
    private func setupContrantsSpinner() {
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        spinner.startAnimating()
        
    }
}
