//
//  UseCase.swift
//  PokemonApp
//
//  Created by Daniel Crespo Duarte on 11/02/25.
//

import Foundation

protocol Interactorable {
    associatedtype Response
    associatedtype Params
    
    func execute(params: Params) async throws -> Response
}

open class AnyUseCase<Input, Output>: Interactorable {
   
    typealias Response = Output
    typealias Params = Input
    
    func execute(params: Input) async throws -> Output {
        fatalError("This method must be implemented")
    }
}
