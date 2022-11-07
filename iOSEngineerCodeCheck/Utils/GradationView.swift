//
//  GradationView.swift
//  iOSEngineerCodeCheck
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func profileGradation(startColor: CGColor, endColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = .init(
            x: self.bounds.minX,
            y: self.bounds.minY,
            width: self.bounds.width,
            height: self.bounds.height - 32 // 角丸をつけるために余白をもたせる目的で引いている
        )
        
        gradientLayer.colors = [startColor, endColor]
        
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5 , y: 1)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
