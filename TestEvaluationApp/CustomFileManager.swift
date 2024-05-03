//
//  CustomFileManager.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/2/24.
//

import Foundation

class CustomFileManager: NSObject {
    
    static let shared: CustomFileManager = {
        let instance = CustomFileManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
}
