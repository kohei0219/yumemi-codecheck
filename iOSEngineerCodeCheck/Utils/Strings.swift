//
//  Strings.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

// 本来はLocalizedStringで管理する
// SwiftGenなどを使う
// https://github.com/SwiftGen/SwiftGen
public enum Strings {
    case searchPlaceHolder
    
    func getText() -> String {
        switch self {
        case .searchPlaceHolder:
            return "GitHubのリポジトリを検索できるよー"
        }
    }
}
