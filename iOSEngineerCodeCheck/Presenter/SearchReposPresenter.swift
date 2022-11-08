//
//  SearchReposPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchReposViewDelegate: AnyObject {
    func reloadData()
    func goDetailVC()
    func fetchFailed(message: String)
    func updateSortTitle()
}

public enum SearchRepoSortStatus: String {
    case stars = "Stars"
    case issues = "Issues"
    case watchers = "Watchers"
    case forks = "Forks"
}

final class SearchReposPresenter: PresenterProtocol {
    typealias View = SearchReposViewDelegate
    typealias Model = SearchReposModelDelegate
    
    unowned let view: View
    let model: Model
    
    private var repos: [RepoData] = []
    private(set) var selectedRepo: RepoData?
    private(set) var sortStatus: SearchRepoSortStatus = .stars
    
    init(model: Model, view: View) {
        self.model = model
        self.view = view
    }
    
    func fetchRepos(searchWord: String?) {
        guard let searchWord = searchWord,
              searchWord.count != 0,
              let url = UrlFormatter.searchRepositories(searchWord).getUrl()
        else { return }
        model.fetchRepos(url: url) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                self?.sortRepos()
                self?.view.reloadData()
            case .failure(let error):
                self?.view.fetchFailed(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        repos.count
    }
    
    func cellViewData(at index: Int) -> RepoData {
        repos[index]
    }
    
    func cacelFetchRepos() {
        model.cancelFetchRepos()
    }
    
    func didTapCell(at index: Int) {
        selectedRepo = cellViewData(at: index)
        view.goDetailVC()
    }
    
    private func sortRepos() {
        switch sortStatus {
        case .stars:
            repos.sort { $0.stargazersCount > $1.stargazersCount }
        case .issues:
            repos.sort { $0.openIssuesCount > $1.openIssuesCount }
        case .watchers:
            repos.sort { $0.watchersCount > $1.watchersCount }
        case .forks:
            repos.sort { $0.forksCount > $1.forksCount }
        }
    }
    
    func didTapSort() {
        switch sortStatus {
        case .stars:
            sortStatus = .issues
        case .issues:
            sortStatus = .watchers
        case .watchers:
            sortStatus = .forks
        case .forks:
            sortStatus = .stars
        }
        sortRepos()
        view.reloadData()
        view.updateSortTitle()
    }
}
