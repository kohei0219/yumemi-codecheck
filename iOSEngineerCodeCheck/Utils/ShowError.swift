//
//  ShowError.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(message: String) {
        let title = "エラー"
        let message = message
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: okText, style: .cancel, handler: nil)
        alert.addAction(okayButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}
