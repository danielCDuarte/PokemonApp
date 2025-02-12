//
//  ErrorHandlerProtocol.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol ErrorHandlerProtocol: AnyObject {
    func showError(error: NetworkError)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

protocol ErrorProcessorProtocol {
    var errorHandler: ErrorHandlerProtocol? { get set }
    func handleException(error: Error, associatedData: Any?)
}

extension ErrorProcessorProtocol {
    func handleException(error: Error, associatedData: Any? = nil) {
        if let error = error as? NetworkError {
            errorHandler?.showError(error: error)
        }
        errorHandler?.showError(error: .serverError)
    }
}
