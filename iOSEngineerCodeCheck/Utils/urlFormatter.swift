//
//  urlFormatter.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

public enum UrlFormatter {
    case searchRepositories(_ searchWord: String)
    
    func getUrl() -> URL? {
        switch self {
        case .searchRepositories(let searchWord):
            return URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        }
    }
}
