//
//  RepoDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepoDetailViewDelegate: AnyObject {
    func setImage(data: Data)
}

final class RepoDetailPresenter: PresenterProtocol {
    typealias View = RepoDetailViewDelegate
    typealias Model = RepoDetailModelDelegate
    
    unowned let view: View
    let model: Model
    
    private let repo: RepoData
    
    init(model: Model, view: View, repo: RepoData) {
        self.model = model
        self.view = view
        self.repo = repo
    }
    
    func fetchImage() {
        let avatarURL = repo.owner["avatar_url"] as? String ?? ""
        guard let imgURL = URL(string: avatarURL) else { return }
        model.fetchImage(imgURL: imgURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.view.setImage(data: data)
            case .failure: break
            }
        }
    }
    
    var language: String {
        "Written in \(repo.language)"
    }
    
    var starts: String {
        "\(repo.stargazersCount) stars"
    }
    
    var watchers: String {
        "\(repo.watchersCount) watchers"
    }
    
    var forks: String {
        "\(repo.forksCount) forks"
    }
    
    var issues: String {
        "\(repo.openIssuesCount) open issues"
    }
    
    var title: String {
        repo.fullName
    }
}
