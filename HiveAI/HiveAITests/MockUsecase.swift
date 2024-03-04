//
//  MockUsecase.swift
//  HiveAITests
//
//  Created by Sannica.Gupta on 02/03/24.
//

import Foundation
@testable import HiveAI

let mockWikipediaData = WikipediaData(pageid: 1,
                                      title: "mock title",
                                      thumbnail: nil,
                                      extract: "mock Description")
final class MockUsecase: Usecase {
    var error: NetworkError?
    func fetchData(searchData: HiveAI.SearchData, completion: @escaping ((Result<HiveAI.SearchResponseData, HiveAI.NetworkError>) -> ())) {
        if let error {
            completion(.failure(error))
        } else {
            let mockQueryData = Query(pages: ["1": mockWikipediaData])
            let mockData = SearchResponseData(batchcomplete: nil,
                                              query: mockQueryData,
                                              limits: nil)
            completion(.success(mockData))
        }
    }
}
