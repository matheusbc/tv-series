//
//  Parsable.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//

protocol Parsable {
    associatedtype ParsedType
    func parse() -> ParsedType
}
