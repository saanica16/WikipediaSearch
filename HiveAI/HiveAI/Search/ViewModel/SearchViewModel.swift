//
//  SearchViewModel.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 01/03/24.
//

import Foundation

final class SearchViewModel: SearchViewModelProtocol {
    var view: SearchViewProtocol?
    var useCase: Usecase
    var searchDataCollection: [WikipediaData]? {
        didSet {
            self.view?.updateData()
        }
    }
    var searchTask: DispatchWorkItem?
    var headerViewHeight: CGFloat {
        if searchDataCollection?.count ?? 0 > 0 {
            return 50.0
        } else {
            return 0
        }
    }
    var customErrorMessage: String {
        return "Please try again later."
    }
    
    
    init(useCase: Usecase) {
        self.useCase = useCase
    }
    
    func onLoad(){
        self.fetchData()
    }
    
    func searchData(searchString: String = String()){
        // debouncing
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                self?.fetchData(searchString: searchString)
            }
          }
          
          self.searchTask = task
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func fetchData(searchString: String = String()){
        guard !searchString.isEmpty else {
            self.searchDataCollection = []
            return
        }
        let searchData = SearchData(searchString: searchString,
                                    gsrlimit: 10)
        self.view?.toggleLoader(show: true)
        self.useCase.fetchData(searchData: searchData) { [weak self]  result in
            guard let self else { return }
            switch result {
            case let .success(response):
                self.searchDataCollection = []
                if let pagesData = response.query?.pages, pagesData.count > 0 {
                    self.searchDataCollection = pagesData.map {$0.value}
                }
                
            case .failure:
                self.view?.updateViewWithError(errorString: self.customErrorMessage)
            }
            self.view?.toggleLoader(show: false)
        }
    }
    
    
    func getNumberOfRows() -> Int {
        return searchDataCollection?.count ?? 0
    }
    
    func cellData(index: Int) -> ResultData? {
        if let cellData = searchDataCollection?[index] {
            let cellData = ResultData(
                title: cellData.title ?? "NA",
                description: cellData.extract ?? "NA",
                imageData: cellData.thumbnail)
            return cellData
        }
        return nil
    }
}

