//
//  RepoData.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

public struct RepoData {
    let avatarUrl: String
    let forksCount: Int
    let fullName: String
    let htmlUrl: String
    let language: String
    let openIssuesCount: Int
    let owner: [String: Any]
    let stargazersCount: Int
    let watchersCount: Int
    
    static func mapData(_ obj: [String: Any]) -> [RepoData] {
        let items = obj["items"] as? [[String: Any]] ?? []
        var repos: [RepoData] = []
        for item in items {
            repos.append(.init(
                avatarUrl: item["avatar_url"] as? String ?? "",
                forksCount: item["forks_count"] as? Int ?? 0,
                fullName: item["full_name"] as? String ?? "",
                htmlUrl: item["html_url"] as? String ?? "",
                language: item["language"] as? String ?? "",
                openIssuesCount: item["open_issues_count"] as? Int ?? 0,
                owner: item["owner"] as? [String: Any] ?? [:],
                stargazersCount: item["stargazers_count"] as? Int ?? 0,
                watchersCount: item["watchers_count"] as? Int ?? 0
            ))
        }
        return repos
    }
}
