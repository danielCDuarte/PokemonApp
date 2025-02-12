//
//  BasePresenter.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol BasePresenterProtocol {
    
    var view: BaseView? { get set }

    func bind(withView view: BaseView)
    func unBind()
    func viewDidLoad()
    func viewWillAppear()
    func getInitialState()
    func reloadData()
}

class BasePresenter: AnyObject, BasePresenterProtocol, ErrorProcessorProtocol {
    
    weak var view: BaseView?
    
    weak var errorHandler: ErrorHandlerProtocol?

    func bind(withView view: BaseView) {
        self.view = view
        self.errorHandler = view
    }

    func unBind() {
        self.view = nil
        self.errorHandler = nil
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func reloadData() {}
    func getInitialState() {}
    func trackScreen() {}
}
