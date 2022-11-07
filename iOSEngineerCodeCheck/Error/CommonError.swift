//
//  CommonError.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

public enum CommonError: Error, LocalizedError, Equatable {
    case fetchFailed
    
    public var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "データの取得に失敗しました"
        }
    }
}
