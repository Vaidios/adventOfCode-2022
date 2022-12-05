import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let splitText = input.split(separator: "\n")

func getBoxStructureFrom(rawData: String) -> [[Character]] {
  
  let boxHeight = (0...8)
  let columnRange = (0 ... 8)
  
  var invertedRawBoxStructure: [String] = []
  for i in boxHeight {
    let index = boxHeight.upperBound - i
    invertedRawBoxStructure.append(String(splitText[index]))
  }
  
  var output: [[Character]] = .init(repeating: [], count: columnRange.upperBound + 1)
  
  for i in boxHeight {
    if i == 0 { continue }
    let row = invertedRawBoxStructure[i]
    
    for column in columnRange {
      let rowIndex = (column * 4) + 1
      
      guard rowIndex < row.count else {
        fatalError("Index is out of bounds, are you sure there is that many columns")
      }
      let stringIndex = String.Index.init(utf16Offset: rowIndex, in: row)
//      print(row[stringIndex])
      let char = Character(unicodeScalarLiteral: row[stringIndex])
      guard char != " " else { continue }
      output[column].append(char)
    }
  }
  
  return output
}

struct Instruction {
  let move: Int
  let from: Int
  let to: Int
}

func getInstructionsFrom(rawData: String) -> [Instruction] {
//  print(splitText[8])
//  print(splitText[9])
//  print(splitText[10])
  let instructions = splitText[9...]
  let output = instructions.map { rawInstruction in
    let splitInstruction = rawInstruction.split(separator: " ")
    return Instruction(
      move: Int(splitInstruction[1])!,
      from: Int(splitInstruction[3])!,
      to: Int(splitInstruction[5])!
    )
  }
  return output
}

var boxStructure = getBoxStructureFrom(rawData: input)
var part2BoxStructure = getBoxStructureFrom(rawData: input)
let instructions = getInstructionsFrom(rawData: input)
//print(boxStructure)
//print(instructions)

for i in 0 ..< instructions.count {
  let instruction = instructions[i]
  var fromColumn = boxStructure[instruction.from - 1]
  var toColumn = boxStructure[instruction.to - 1]
  let moveRange = (0 ..< instruction.move)
  
  var part2FromColumn = part2BoxStructure[instruction.from - 1]
  var part2ToColumn = part2BoxStructure[instruction.to - 1]
  
  print("Instruction no. \(i)")
  print(instruction)
  print(boxStructure[instruction.from - 1])
  print(boxStructure[instruction.to - 1])
  
  if instruction.move == 1 {
    guard let itemToMove = fromColumn.popLast() else {
      print("Not enough items")
      continue
    }
    toColumn.append(itemToMove)
  } else {
    for moveIndex in moveRange {
//      let index = fromColumn.count - 1 - moveIndex
      guard let itemToMove = fromColumn.popLast() else {
        print("Not enough items")
        continue
      }
      toColumn.append(itemToMove)
    }
  }
  
  if instruction.move == 1 {
    guard let itemToMove = part2FromColumn.popLast() else {
      print("Not enough items")
      continue
    }
    part2ToColumn.append(itemToMove)
  } else {
    let part2Range = ((part2FromColumn.count - instruction.move) ... part2FromColumn.count - 1)
//    print("\(part2Range.lowerBound) to \(part2Range.upperBound)")
    
    for i in part2Range {
//      let index = fromColumn.count - 1 - moveIndex
      let itemToMove = part2FromColumn[i]
      part2ToColumn.append(itemToMove)
    }
    part2FromColumn.removeLast(instruction.move)
  }

  boxStructure[instruction.from - 1] = fromColumn
  boxStructure[instruction.to - 1] = toColumn
  part2BoxStructure[instruction.from - 1] = part2FromColumn
  part2BoxStructure[instruction.to - 1] = part2ToColumn
  print(boxStructure[instruction.from - 1])
  print(boxStructure[instruction.to - 1])
  
  print("")
}

let answer = boxStructure.map({
  guard let answer = $0.last else {
    return ""
  }
  
  return String(answer)
})

let part2answer = part2BoxStructure.map({
  guard let answer = $0.last else {
    return ""
  }
  
  return String(answer)
})

print(answer)
print("Answer to part 1 is \(answer.reduce("", +))")


print(answer)
print("Answer to part 2 is \(part2answer.reduce("", +))")
