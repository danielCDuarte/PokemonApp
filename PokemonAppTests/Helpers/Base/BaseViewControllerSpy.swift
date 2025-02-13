//
//  BaseViewControllerSpy.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 13/02/25.
//

@testable import PokemonApp
import UIKit

class BaseViewControllerSpy: UIViewController, BaseView {
    
    var showErrorCallBack: (() -> Void)?
    var showLoadingIndicatorCallBack: (() -> Void)?
    var hideLoadingIndicatorCallBack: (() -> Void)?

    
    func showError(error: NetworkError) {
        showErrorCallBack?()
    }
    
    
    func showLoadingIndicator() {
        showLoadingIndicatorCallBack?()
    }
    
    func hideLoadingIndicator() {
        hideLoadingIndicatorCallBack?()
    }
    
}
