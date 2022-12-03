import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let splitInput = input.split(separator: "\n", omittingEmptySubsequences: false)

var partOneTotalPoints: Int = 0
var partTwoTotalPoints: Int = 0

for element in splitInput {
  let options = element.split(separator: " ")
  
  if options.count != 2 { break }
  let a = options[0]
  let b = options[1]
  
  // Rock - A/X(1, lose)
  // Paper - B/Y(2, draw)
  // Scissors - C/Z(3, win)
  var partOnePoints: Int = 0
  var partTwoPoints: Int = 0
  
  switch (a,b) {
    // Lost games
  case ("A","Z"):
    partOnePoints += 3 + 0
    partTwoPoints += 2 + 6
  case ("B","X"):
    partOnePoints += 1 + 0
    partTwoPoints += 1 + 0
  case ("C","Y"):
    partOnePoints += 2 + 0
    partTwoPoints += 3 + 3
    
  case ("A","X"):
    partOnePoints += 1 + 3
    partTwoPoints += 3 + 0
  case ("B","Y"):
    partOnePoints += 2 + 3
    partTwoPoints += 2 + 3
  case ("C","Z"):
    partOnePoints += 3 + 3
    partTwoPoints += 1 + 6
    
  case ("A","Y"):
    partOnePoints += 2 + 6
    partTwoPoints += 1 + 3
  case ("B","Z"):
    partOnePoints += 3 + 6
    partTwoPoints += 3 + 6
  case ("C","X"):
    partOnePoints += 1 + 6
    partTwoPoints += 2 + 0
    
  default:
    fatalError("Unhandled case \(a) and \(b)")
  }
  
  partOneTotalPoints += partOnePoints
  partTwoTotalPoints += partTwoPoints
}

print("Part 1")
print("Total points is \(partOneTotalPoints)")
print("")
print("Part 2")
print("Total points is \(partTwoTotalPoints)")
