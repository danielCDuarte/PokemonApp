//
//  BaseViewController.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
 
    var spinnerViewController: SpinnerViewController?
    var errorViewViewController: ErrorViewController?
    
    var presenter: BasePresenterProtocol!
    
    deinit {
        presenter?.unBind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func showError(error: NetworkError) {
        errorViewViewController = ErrorViewController(error: error, retryAction: { [weak self] in
            self?.presenter.reloadData()
        })
        if let errorViewViewController = errorViewViewController {
            errorViewViewController.modalPresentationStyle = .overFullScreen
            errorViewViewController.modalTransitionStyle = .crossDissolve
            present(errorViewViewController, animated: true)
        }
    }
    
    func showLoadingIndicator() {
        spinnerViewController = SpinnerViewController()
        if let spinnerViewController = spinnerViewController {
            addChild(spinnerViewController)
            spinnerViewController.view.frame = view.frame
            view.addSubview(spinnerViewController.view)
            spinnerViewController.didMove(toParent: self)
        }
        
    }
    
    func hideLoadingIndicator() {
        if let spinnerViewController = spinnerViewController {
            spinnerViewController.willMove(toParent: nil)
            spinnerViewController.view.removeFromSuperview()
            spinnerViewController.removeFromParent()
        }
    }
}
