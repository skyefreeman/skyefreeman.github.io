#!/usr/bin/env xcrun swift

import Foundation

struct Arguments {
    let fileName : String
    let postTitle : String
    let postCategory : String
    
    init(args:[String]){
        self.fileName = args[1]
        self.postTitle = args[2]
        self.postCategory = args[3]
    }
}

func argumentsValid(args : [String]) -> Bool {
    return args.count < 4 || args.count > 4
}

extension NSFileManager {
    func createDirectoryAtPath(path: String) {
        do { try self.createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil) } catch {}
    }
    
    func createFile(path: String, name: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let titleDateString = dateFormatter.stringFromDate(NSDate())
        let formattedPostFileName = "\(titleDateString)-\(name).markdown"
        let completeNewPath = "\(path)/\(formattedPostFileName)"
        self.createFileAtPath(completeNewPath, contents: nil, attributes: nil)
        return completeNewPath
    }
}

extension String {
    func postInfoString(args : Arguments) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(NSDate())
        return "---\nlayout: post \ntitle: \"\(args.postTitle)\" \ndate: \(dateString) \nauthor: Skye Freeman \ncategories: \(args.postCategory)\n---"
    }
}

/* 

   Begin Script

*/

// Check if a new post name was passed in
let tempArgs = Process.arguments
if(argumentsValid(tempArgs)) {
    print("\n Usage:")
    print("\n   $ ./newpost FILENAME POSTNAME CATEGORY \n")
    exit(0)
}
let args = Arguments(args: tempArgs)

// The File system manager
let fileManager = NSFileManager.defaultManager()

// Create a _drafts directory
let draftsDirPath = "./_drafts"
fileManager.createDirectoryAtPath(draftsDirPath)

// Create a new post file, return the path
let finalPath = fileManager.createFile(draftsDirPath, name: args.fileName)

// Write info to file
do {
    try String().postInfoString(args).writeToFile(finalPath, atomically: false, encoding: NSUTF8StringEncoding)
    print("Done")
} catch {
    print("Error writing to file \(finalPath)")
}

