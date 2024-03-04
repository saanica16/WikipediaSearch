//
//  MockView.swift
//  HiveAITests
//
//  Created by Sannica.Gupta on 02/03/24.
//

import Foundation
@testable import HiveAI

final class MockView: SearchViewProtocol {
    var errorString = ""
    var successString = ""
    var toggleLoader = false
    
    func updateData() {
        successString = "success"
    }
    
    func updateViewWithError(errorString: String) {
        self.errorString = "error"
    }
    
    func toggleLoader(show: Bool) {
        toggleLoader = show
    }
}
