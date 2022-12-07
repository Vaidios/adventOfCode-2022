import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let commands = input.split(separator: "\n")

final class Directory {
  
  let name: String
  
  var size: UInt {
    files.reduce(0, { $0 + $1.size })
    + directories.reduce(0, { $0 + $1.size })
  }
  
  let parent: Directory?
  var directories: [Directory]
  var files: [File]
  
  init(name: String, parent: Directory?, directories: [Directory], files: [File]) {
    self.parent = parent
    self.name = name
    self.directories = directories
    self.files = files
    
  }
  
  func getSumOfDirectorySizes(below directorySize: UInt) -> UInt {
    let childrenSumOfSizes = directories.reduce(0, { $0 + $1.getSumOfDirectorySizes(below: directorySize) })
    if self.size <= directorySize {
      return self.size
      + childrenSumOfSizes
    } else {
      return childrenSumOfSizes
    }
  }
  
  func getDirectoriesWithSize(above directorySize: UInt) -> [Directory] {
    let childrenBelowSize = directories.map({ $0.getDirectoriesWithSize(above: directorySize) }).flatMap( { $0 })
    if self.size > directorySize {
      return [self] + childrenBelowSize
    } else {
      return childrenBelowSize
    }
  }
}

struct File {
  let name: String
  let size: UInt
}

var rootDirectory: Directory = .init(name: "/", parent: nil, directories: [], files: [])

var currentDirectory: Directory?

var iteration: Int = 0
for command in commands {
  iteration += 1
  
  print("No. \(iteration)")
  
  let arguments = command.split(separator: " ")
  

  if arguments[0] == "$" { // handle command
    switch arguments[1] {
    case "cd":
      if arguments[2] == "/" {
        print("Moved into root")
        currentDirectory = rootDirectory
      } else if arguments[2] == ".." {
        guard let parent = currentDirectory?.parent else { fatalError("No parent directory") }
        print("Moved into parent \(parent.name)")
        currentDirectory = parent
      } else {
        guard let currentContextParent = currentDirectory else { fatalError("Current directory has not been set") }
        
        if let nextDirectory = currentContextParent.directories.first(where: { $0.name == arguments[2] }) {
          currentDirectory = nextDirectory
          print("Moved into \(nextDirectory.name)")
        } else {
          let newDirectory = Directory(
            name: String(arguments[2]),
            parent: currentDirectory,
            directories: [],
            files: []
          )
          currentContextParent.directories.append(newDirectory)
          
          currentDirectory = newDirectory
          print("Moved into \(newDirectory.name)")
        }
      }
      
    case "ls":
      print("ls")
    default:
      fatalError("Unrecognized command \(command)")
    }
  } else { // handle list item
    guard let currentDirectory else { fatalError("Current directory not available") }
    if arguments[0] == "dir" {
      if currentDirectory.directories.contains(where: { $0.name == arguments[1] }) {
       print("Directory exists \(arguments[1])")
      } else {
        let newDirectory = Directory(
          name: String(arguments[1]),
          parent: currentDirectory,
          directories: [],
          files: []
        )
        currentDirectory.directories.append(newDirectory)
        print("Found new directory \(newDirectory.name)")
      }
      
    } else {
      if currentDirectory.files.contains(where: { $0.name == arguments[1] }) {
       print("File exists \(arguments[1])")
      } else {
        let file = File(name: String(arguments[1]), size: UInt(arguments[0])!)
        currentDirectory.files.append(file)
        print("Found new file \(file.size)")
      }
    }
  }
}

let filesystemSize: UInt = 70_000_000
let neededSpace: UInt = 30_000_000
let spaceLeft = filesystemSize - rootDirectory.size

if neededSpace > spaceLeft {
  let neededSpaceToBeRemoved = neededSpace - spaceLeft
  print("Still need \(neededSpaceToBeRemoved)")
  
  let bigEnoughDirectories = rootDirectory.getDirectoriesWithSize(above: neededSpaceToBeRemoved)
    .sorted(by: { $0.size < $1.size })
  
  print("\(bigEnoughDirectories[0].size) \(bigEnoughDirectories[1].size)")
  
} else {
  print("There is enough space")
}

// 6_728_267

print("Total size if root is \(rootDirectory.size)")

print("Total size of directiories below 100 000 is \(rootDirectory.getSumOfDirectorySizes(below: 100_000))")
