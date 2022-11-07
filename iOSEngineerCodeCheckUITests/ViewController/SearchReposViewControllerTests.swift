//
//  SearchReposViewControllerTests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class SearchReposViewControllerTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_textField() {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields.firstMatch
        XCTAssertEqual(searchField.value as! String, "GitHubのリポジトリを検索できるよー")
        
        searchField.tap()
        XCTAssertEqual(searchField.value as! String, "")
    }
}
