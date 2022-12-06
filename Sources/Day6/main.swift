import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

var currentCharIndex = 0
var word: [Character] = []
var countDictionary: [Character: Int] = [:]
var poppedCharacters: [Character] = []
for char in input {
  currentCharIndex += 1
  word.append(char)
  
  if let letterCount = countDictionary[char] {
    countDictionary[char] = letterCount + 1
  } else {
    countDictionary[char] = 1
  }
  
  if word.count == 14 {
    var isRepeating: Bool = false
    
    for finalChar in word {
      guard let letterCount = countDictionary[finalChar] else { continue }
      
      if letterCount > 1 {
        isRepeating = true
      }
    }
    
    if isRepeating {
      
      print("No. \(currentCharIndex) repeating")
      print("Word \(word)")
      print("Popped \(poppedCharacters.count)")
      print(countDictionary)
      
      let removedChar = word.removeFirst()
      poppedCharacters.append(removedChar)
      
      if let letterCount = countDictionary[removedChar] {
        if (letterCount - 1) < 1 {
          countDictionary[removedChar] = nil
        } else {
          countDictionary[removedChar] = letterCount - 1
        }
      } else {
        countDictionary[removedChar] = nil
      }
    } else {
      
      print("No. \(currentCharIndex) non repeating")
      print("Word \(word)")
      print("Popped \(poppedCharacters.count)")
      print(countDictionary)
      
//      print(input.count)
//      input.contain
//      print(word)
      break
    }
    
  }
}

//1196
//1195
