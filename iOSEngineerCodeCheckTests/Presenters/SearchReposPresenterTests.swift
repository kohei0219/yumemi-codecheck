//
//  SearchReposPresenterTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest

@testable import iOSEngineerCodeCheck

final class SearchReposPresenterTests: XCTestCase {
    private var presenter: SearchReposPresenter!
    private var model: SearchReposModelDelegateMock!
    private var view: SearchReposViewDelegateMock!
    
    private let repos: [RepoData] = [.init(avatarUrl: "avatar", forksCount: 2, fullName: "fullName", htmlUrl: "htmlUrl", language: "language", openIssuesCount: 3, owner: ["avatar_url": "url"], stargazersCount: 4, watchersCount: 5)]
    
    override func setUp() {
        super.setUp()
        view = .init()
        model = .init()
        presenter = .init(model: model, view: view)
    }
    
    private func getRepos() {
        model.fetchReposHandler = {
            url, completion in
            completion(.success(self.repos))
        }
        presenter.fetchRepos(searchWord: "hoge")
    }
    
    func test_fetchRepos() {
        XCTxContext("Repositoryの取得に成功すること") {
            model.fetchReposHandler = {
                url, completion in
                XCTAssertEqual(url, UrlFormatter.searchRepositories("hoge").getUrl())
                completion(.success(self.repos))
            }
            presenter.fetchRepos(searchWord: "hoge")
            XCTAssertEqual(model.fetchReposCallCount, 1)
            XCTAssertEqual(view.reloadDataCallCount, 1)
        }
        
        XCTxContext("データの取得に失敗すること") {
            model.fetchReposHandler = {
                url, completion in
                XCTAssertEqual(url, UrlFormatter.searchRepositories("hoge").getUrl())
                completion(.failure(CommonError.fetchFailed))
            }
            presenter.fetchRepos(searchWord: "hoge")
            XCTAssertEqual(model.fetchReposCallCount, 1)
            XCTAssertEqual(view.reloadDataCallCount, 0)
            XCTAssertEqual(view.fetchFailedCallCount, 1)
        }
    }
    
    func test_numberOfRows() {
        XCTAssertEqual(presenter.numberOfRows(), 0)
        getRepos()
        XCTAssertEqual(presenter.numberOfRows(), 1)
    }
    
    func test_cellViewData() {
        getRepos()
        XCTAssertEqual(presenter.cellViewData(at: 0).fullName, repos[0].fullName)
    }
    
    func test_cacelFetchRepos() {
        presenter.cacelFetchRepos()
        XCTAssertEqual(model.cancelFetchReposCallCount, 1)
    }
    
    func test_didTapCell() {
        getRepos()
        XCTAssertNil(presenter.selectedRepo)
        presenter.didTapCell(at: 0)
        XCTAssertEqual(presenter.selectedRepo?.fullName, repos[0].fullName)
        XCTAssertEqual(view.goDetailVCCallCount, 1)
    }
    
    func test_didTapSort() {
        XCTAssertEqual(presenter.sortStatus, .stars)
        presenter.didTapSort()
        XCTAssertEqual(presenter.sortStatus, .issues)
        XCTAssertEqual(view.reloadDataCallCount, 1)
        XCTAssertEqual(view.updateSortTitleCallCount, 1)
        presenter.didTapSort()
        XCTAssertEqual(presenter.sortStatus, .watchers)
        presenter.didTapSort()
        XCTAssertEqual(presenter.sortStatus, .forks)
        presenter.didTapSort()
        XCTAssertEqual(presenter.sortStatus, .stars)
    }
}
