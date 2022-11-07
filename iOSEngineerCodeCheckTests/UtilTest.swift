//
//  UtilTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 盛野晃平 on 2022/11/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest

public protocol ContextExecutable {
    func XCTxContext(_ named: String, shouldSetUp: Bool, shouldTearDown: Bool, block: ()->())
}

extension XCTestCase: ContextExecutable {
    public func XCTxContext(_ named: String, shouldSetUp: Bool = true, shouldTearDown: Bool = true, block: ()->()) {
        if shouldSetUp {
            self.setUp()
        }
        XCTContext.runActivity(named: named, block: { _ in block() })
        if shouldTearDown {
            self.tearDown()
        }
    }
}
