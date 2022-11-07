//
//  VCIdentifiers.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

public enum VCIdentifiers {
    case detailRepo
    
    func getId() -> String {
        switch self {
        case .detailRepo:
            return "RepoDetailViewController"
        }
    }
}
