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
    
    func getDocumentDirectory() -> URL?
    {
        if let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return docDirectoryURL
        }
        return nil
    }
    
    func libraryDirectoryPath() -> URL? {
        if let libraryDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: .userDomainMask).first {
            return libraryDirectoryURL
        }
        return nil
    }
    
    func tempDirectoryPath() -> URL {
        return FileManager.default.temporaryDirectory
        
        func isWritable(file atPath: URL) -> Bool {
            return FileManager.default.isWritableFile(atPath: atPath.path)
        }
        
        func isReadable(file atPath: URL) -> Bool {
            return FileManager.default.isReadableFile(atPath: atPath.path)
        }
        
        func isExist(file atPath: URL) -> Bool {
            return FileManager.default.fileExists(atPath: atPath.path)
        }
    }
    
    func writeFileIn(containingString: String, to path: URL, with name: String) -> Bool {
        let filePath = path.path
        let completePath = filePath + "/" + name
        let data: Data? = containingString.data(using: .utf8)
        return FileManager.default.createFile(atPath: completePath, contents: data, attributes: nil)
    }
    
    func readFile(at path: URL, withName: String) -> String? {
        
        let completePath = path.path + "/" + withName
        if let fileContent = FileManager.default.contents(atPath: completePath) {
            if let fileStringData = String(bytes: fileContent, encoding: .utf8) {
                return fileStringData
            }
        }
        return nil
    }
    
}
