//
//  HiveAITests.swift
//  HiveAITests
//
//  Created by Sannica.Gupta on 27/02/24.
//

import XCTest
@testable import HiveAI

final class HiveAITests: XCTestCase {
    var useCase = MockUsecase()
    let mockView = MockView()
    var viewModel: SearchViewModel {
        let vm = SearchViewModel(useCase: useCase)
        vm.view = mockView
        return vm
    }
    
    func testApiSuccess() {
        viewModel.fetchData(searchString: "apple")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.searchDataCollection?.count, 1)
        }
    }
    
    func testApiFailure() {
        useCase.error = .apiError
        viewModel.fetchData(searchString: "apple")
        XCTAssertEqual(mockView.errorString, "error")
    }
}
