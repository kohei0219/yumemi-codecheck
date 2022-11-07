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
}

final class SearchReposPresenter: PresenterProtocol {
    typealias View = SearchReposViewDelegate
    typealias Model = SearchReposModelDelegate
    
    unowned let view: View
    let model: Model
    
    private var repos: [RepoData] = []
    private(set) var selectedRepo: RepoData?
    
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
                self?.view.reloadData()
            case .failure: break
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
}
