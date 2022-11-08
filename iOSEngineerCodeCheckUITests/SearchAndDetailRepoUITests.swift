//
//  SearchReposViewControllerTests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class  SearchAndDetailRepoUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_textField() {
        let app = XCUIApplication()
        app.launch()
        
        // searchBarのテスト
        let searchField = app.searchFields.firstMatch
        XCTAssertEqual(searchField.value as! String, "GitHubのリポジトリを検索できるよー")
        
        searchField.tap()
        XCTAssertEqual(searchField.value as! String, "")
        
        searchField.typeText("swift")
        XCTAssertEqual(searchField.value as! String, "swift")
        app.buttons["Search"].tap()
        
        // 検索結果の取得を待つ
        sleep(5)
        
        // ソートボタンのテスト
        let rightButton = app.navigationBars.buttons.firstMatch
        XCTAssertEqual(rightButton.label, "Stars")
        rightButton.tap()
        XCTAssertEqual(rightButton.label, "Issues")
        rightButton.tap()
        XCTAssertEqual(rightButton.label, "Watchers")
        rightButton.tap()
        XCTAssertEqual(rightButton.label, "Forks")
        rightButton.tap()
        XCTAssertEqual(rightButton.label, "Stars")
        
        sleep(2)
        
        // 検索結果の一番上をタップ
        let tables = app.tables
        XCTAssertNotEqual(tables.count, 0)
        let firstCell = tables.cells.element(boundBy: 0)
        let title = firstCell.staticTexts.firstMatch.label
        let lang = firstCell.staticTexts.element(boundBy: 1).label
        firstCell.tap()
        
        sleep(1)
        
        // RepoDetailVCに遷移された
        let titleLabel = app.staticTexts.firstMatch
        XCTAssertEqual(titleLabel.label, title)
        let langLabel = app.staticTexts.element(boundBy: 1)
        XCTAssertEqual(langLabel.label, "Written in " + lang)
        
        // 戻るボタンのタイトルが空になっていること
        XCTAssertTrue(app.navigationBars.buttons.firstMatch.title.isEmpty)
        
        let bookmarkButton = app.navigationBars.buttons.element(boundBy: 1)
        bookmarkButton.tap()
        // アラートが現れる
        XCTAssertTrue(app.alerts.element.exists)
        app.alerts.buttons.firstMatch.tap()
        XCTAssertFalse(app.alerts.element.exists)
        
        let width = XCUIApplication().windows.element(boundBy: 0).frame.size.width
        let visitButton = app.buttons.element(boundBy: 2)
        // デバイスのサイズが小さい場合はボタンが隠されている
        if width <= 320 {
            XCTAssertFalse(visitButton.exists && visitButton.isHittable)
        } else {
            visitButton.tap()
            
            let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
            
            sleep(3)
            XCTAssertFalse(safari.textFields.firstMatch.label.isEmpty)
            // safariからアプリに戻る
            app.activate()
        }
    }
}
