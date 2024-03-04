//
//  SearchViewProtocols.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 01/03/24.
//

import Foundation

protocol SearchViewProtocol {
    func updateData()
    func updateViewWithError(errorString: String)
    func toggleLoader(show: Bool)
}

protocol SearchViewModelProtocol {
    var view: SearchViewProtocol? { get set }
    func getNumberOfRows() -> Int
    func cellData(index: Int) -> ResultData?
    func fetchData(searchString: String)
}
