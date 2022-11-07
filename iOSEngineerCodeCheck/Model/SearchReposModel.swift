//
//  SearchReposModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchReposModelDelegate {
    func fetchRepos(url: URL,  completion: @escaping (Result<[RepoData], Error>) -> Void)
    func cancelFetchRepos()
}

final class SearchReposModel: SearchReposModelDelegate {
    private var searchRepos: URLSessionTask?
    
    func fetchRepos(url: URL,  completion: @escaping (Result<[RepoData], Error>) -> Void) {
        searchRepos = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                completion(.success(RepoData.mapData(obj)))
            }
        }
        // リストを更新する
        searchRepos?.resume()
    }
    
    func cancelFetchRepos() {
        searchRepos?.cancel()
    }
}
