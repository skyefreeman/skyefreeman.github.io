#!/usr/bin/env xcrun swift

import Foundation

struct Arguments {
    private let args: [String]
    
    var fileName: String?

    var valid: Bool {
        return args.count == 2
    }
    
    init(args:[String]) {
        self.args = args
        if args.count > 1 {
            self.fileName = args[1]
        }
    }
}

extension String {
    static func postInfoString(withArgs args : Arguments) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        return "---\nlayout: post \ntitle: \ndate: \(dateString) \nauthor: Skye Freeman \ncategories: \n---"
    }
}

extension FileManager {
    func createDirectory(withPath path: String) {
        do {
            try createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch {}
    }

    func createFile(withPath path: String, name: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let titleDateString = dateFormatter.string(from: Date())
        let formattedPostFileName = "\(titleDateString)-\(name).markdown"
        let completeNewPath = "\(path)/\(formattedPostFileName)"
        
        createFile(atPath: completeNewPath, contents: nil, attributes: nil)
        return completeNewPath
    }
}

/* Script */

// Check if a new post name was passed in
let tempArgs = CommandLine.arguments
let args = Arguments(args: tempArgs)
if args.valid == false {
    print("\n Usage:")
    print("\n   $ ./newpost FILENAME POSTNAME CATEGORY \n")
    exit(0)
}

// The File system manager
let fileManager = FileManager.default

// Create a _drafts directory
let draftsDirPath = "./_drafts"
fileManager.createDirectory(withPath: draftsDirPath)

// Create a new post file, return the path
let newFileName = args.fileName
let finalPath = fileManager.createFile(withPath: draftsDirPath, name: args.fileName!)

// Write info to file
do {
    try String.postInfoString(withArgs: args).write(toFile: finalPath, atomically: false, encoding: String.Encoding.utf8)
    print("Done")
} catch {
    print("Error writing to file \(finalPath)")
}

