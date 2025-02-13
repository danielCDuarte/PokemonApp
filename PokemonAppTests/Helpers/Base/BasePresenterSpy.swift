//
//  BasePresenterSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp
import Foundation

class BasePresenterSpy: BasePresenterProtocol {
    var bindCallBack: (() -> Void)?
    var unBindCallBack: (() -> Void)?
    var viewDidLoadCallBack: (() -> Void)?
    var viewWillAppearCallBack: (() -> Void)?
    var getInitialStateCallBack: (() -> Void)?
    var reloadDataCallBack: (() -> Void)?
    
    var view: BaseView?
    
    func bind(withView view: BaseView) {
        bindCallBack?()
    }
    
    func unBind() {
        unBindCallBack?()
    }
    
    func viewDidLoad() {
        viewDidLoadCallBack?()
    }
    
    func viewWillAppear() {
        viewWillAppearCallBack?()
    }
    
    func getInitialState() {
        getInitialStateCallBack?()
    }
    
    func reloadData() {
        reloadDataCallBack?()
    }
}
