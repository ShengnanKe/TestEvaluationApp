//
//  DBManager.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/1/24.
//

// FileManager for DB

import UIKit

class DBManager: NSObject {
    
    var managedContext: NSManagedObjectContext!
        
        static let shared: DBManager = {
            let instance = DBManager()
            return instance
        }()
        
        private override init() {
            super.init()
            let application = UIApplication.shared
            let appDelegate = application.delegate as? AppDelegate
            let container = appDelegate?.persistentContainer
            self.managedContext = container?.viewContext
        }

}
