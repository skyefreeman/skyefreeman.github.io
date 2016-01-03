#!/usr/bin/env xcrun swift
import Foundation

let args = Process.arguments
let newPostFileName : String
let newPostTitle : String
let newPostCategory : String

// Check if a new post name was passed in
if(args.count < 4 || args.count > 4) {
    print("\n Usage:")
    print("\n   $ ./newpost FILENAME POSTNAME CATEGORY \n")
    exit(0)
} else {
    newPostFileName = args[1]
    newPostTitle = args[2]
    newPostCategory = args[3]
}

// The File system manager
let fileManager = NSFileManager.defaultManager()

// Create a _drafts directory
let draftsDirPath = "./_drafts"
do {
    try fileManager.createDirectoryAtPath(draftsDirPath, withIntermediateDirectories: false, attributes: nil)
} catch {}

// Create a new post file
let now = NSDate()
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
let titleDateString = dateFormatter.stringFromDate(NSDate())
let formattedPostFileName = "\(titleDateString)-\(newPostFileName)"

let newPostFilePath = "\(draftsDirPath)/\(formattedPostFileName).markdown"
if (fileManager.fileExistsAtPath(newPostFilePath)) {
    print("File at path already exists")
    exit(0)
} else {
    fileManager.createFileAtPath(newPostFilePath, contents: nil, attributes: nil)
    print("\(newPostFilePath) created.")
}

// New Post Info String
//---
//layout: post
//title:  "Dummy Post"
//date:   2015-04-18 08:43:59
//author: Ben Centra
//categories: Dummy
//---

dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
let dateString = dateFormatter.stringFromDate(now)
let postInfo = "---\nlayout: post \ntitle: \"\(newPostTitle)\" \ndate: \(dateString) \nauthor: Skye Freeman \ncategories: \(newPostCategory)\n---"

// Write info to file
do {
    try postInfo.writeToFile(newPostFilePath, atomically: false, encoding: NSUTF8StringEncoding)
    print("Done")
} catch {
    print("Error writing to file \(newPostFilePath)")
}

