//
//  Mocks.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

@testable import iOSEngineerCodeCheck

class SearchReposViewDelegateMock: SearchReposViewDelegate {
    init() {}
    
    private(set) var reloadDataCallCount = 0
    var reloadDataHandler: (() -> ())?
    func reloadData() {
        reloadDataCallCount += 1
        if let reloadDataHandler = reloadDataHandler {
            reloadDataHandler()
        }
    }
    
    private(set) var goDetailVCCallCount = 0
    var goDetailVCHandler: (() -> ())?
    func goDetailVC() {
        goDetailVCCallCount += 1
        if let goDetailVCHandler = goDetailVCHandler {
            goDetailVCHandler()
        }
    }
    
    private(set) var fetchFailedCallCount = 0
    var fetchFailedHandler: (() -> ())?
    func fetchFailed(message: String) {
        fetchFailedCallCount += 1
        if let fetchFailedHandler = fetchFailedHandler {
            fetchFailedHandler()
        }
    }
    
    private(set) var updateSortTitleCallCount = 0
    var updateSortTitleHandler: (() -> ())?
    func updateSortTitle() {
        updateSortTitleCallCount += 1
        if let updateSortTitleHandler = updateSortTitleHandler {
            updateSortTitleHandler()
        }
    }
}

class SearchReposModelDelegateMock: SearchReposModelDelegate {
    init() {}
    
    private(set) var fetchReposCallCount = 0
    var fetchReposHandler: ((URL, @escaping (Result<[RepoData], Error>) -> Void) -> ())?
    func fetchRepos(url: URL, completion: @escaping (Result<[RepoData], Error>) -> Void) {
        fetchReposCallCount += 1
        if let fetchReposHandler = fetchReposHandler {
            fetchReposHandler(url, completion)
        }
    }
    
    private(set) var cancelFetchReposCallCount = 0
    var cancelFetchReposHandler: (() -> ())?
    func cancelFetchRepos() {
        cancelFetchReposCallCount += 1
        if let cancelFetchReposHandler = cancelFetchReposHandler {
            cancelFetchReposHandler()
        }
    }
}
