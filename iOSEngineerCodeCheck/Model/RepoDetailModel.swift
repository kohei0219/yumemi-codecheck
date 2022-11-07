//
//  RepoDetailModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepoDetailModelDelegate {
    func fetchImage(imgURL: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class RepoDetailModel: RepoDetailModelDelegate {
    func fetchImage(imgURL: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: imgURL) { (data, res, err) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(CommonError.fetchFailed))
            }
        }
        .resume()
    }
}
