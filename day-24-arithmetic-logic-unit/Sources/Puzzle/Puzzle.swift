import AdventKit
import CoreVideo
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func debug(_ v: [String: Int]) {
        print("w: \(v["w"]!), x: \(v["x"]!), y: \(v["y"]!), z: \(v["z"]!)")
    }

    public func part1() -> Int {
        for w14 in stride(from: 9, through: 1, by: -1) {
            for w13 in stride(from: 9, through: 1, by: -1) {
                for w12 in stride(from: 9, through: 1, by: -1) {
                    for w11 in stride(from: 8, through: 1, by: -1) {
                        for w10 in stride(from: 9, through: 1, by: -1) {
                            for w9 in stride(from: 9, through: 1, by: -1) {
                                for w8 in stride(from: 9, through: 1, by: -1) {
                                    for w7 in stride(from: 2, through: 1, by: -1) { //
                                        for w6 in stride(from: 6, through: 1, by: -1) {
                                            for w5 in stride(from: 9, through: 4, by: -1) {
                                                for w4 in stride(from: 9, through: 6, by: -1) {
                                                    for w3 in stride(from: 4, through: 1, by: -1) {
                                                        for w2 in stride(from: 9, through: 1, by: -1) {
                                                            for w1 in stride(from: 9, through: 1, by: -1) {
                                                                let monad = Int("\(w1)\(w2)\(w3)\(w4)\(w5)\(w6)\(w7)\(w8)\(w9)\(w10)\(w11)\(w12)\(w13)\(w14)")!
                                                                let r = process2(monad: monad)
                                                                if r == 0 {
                                                                    return monad
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return -1
    }

    func process2(monad: Int) -> Int {
        var digits: [Int] = "\(monad)".compactMap { Int("\($0)") }
        if digits.contains(0) {
            return -1
        }

        var w = 0, x = 0, y = 0, z = 0

        w = digits.removeFirst() // 1
        x = 1
        y = w + 14
        z = y
        w = digits.removeFirst() // 2
        x = 1
        y = w + 8
        z = z * 26 + y
        w = digits.removeFirst() // 3
        x = 1
        y = w + 5
        z = z * 26 + y
        w = digits.removeFirst() // 4
        x = y
        z = z / 26
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 4
        y = y * x
        z = z + y
        w = digits.removeFirst() // 5  !!
        x = 1
        y = 26
        y = w + 10
        z = z * 26 + y
        w = digits.removeFirst() // 6
        x = z % 26 // gelijk aan y???
        z = z / 26
        x = x + -13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst() // 7 !!
        x = z % 26
        x = x + 10
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0 // altijd 1
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 16
        y = y * x
        z = z + y
        w = digits.removeFirst() // 8
        x = z % 26
        z = z / 26
        x = x + -9
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 5
        y = y * x
        z = z + y
        w = digits.removeFirst() // 9 !!
        x = z % 26
        x = x + 11
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0 // altijd 1
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 6
        y = y * x
        z = z + y
        w = digits.removeFirst() // 10
        x = z % 26
        x = x + 13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0 // altijd 1 ?
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst() // 11
        x = z % 26
        z = z / 26
        x = x + -14
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 6
        y = y * x
        z = z + y
        w = digits.removeFirst() // 12 !!
        x = z % 26
        z = z / 26
        x = x + -3
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 7
        y = y * x
        z = z + y
        w = digits.removeFirst() // 13 !!
        x = z % 26
        z = z / 26
        x = x + -2
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst() // 14
        x = z % 26
        z = z / 26
        x = x + -14
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = 25
        y = y * x
        y = y + 1
        z = z * y
        y = w
        y = y + 3
        y = y * x
        z = z + y

        return z
    }

    func process3(monad: Int) -> Int {
        var digits: [Int] = "\(monad)".compactMap { Int("\($0)") }
        if digits.contains(0) {
            return -1
        }

        var w = 0, x = 0, y = 0, z = 0

        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 14
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 12
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 8
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 11
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 5
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + 0
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 4
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 15
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 10
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 10
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 16
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -9
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 5
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 11
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 6
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 1
        x = x + 13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -14
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 6
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -3
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 7
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -2
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 13
        y = y * x
        z = z + y
        w = digits.removeFirst()
        x = x * 0
        x = x + z
        x = x % 26
        z = z / 26
        x = x + -14
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y = y * 0
        y = y + 25
        y = y * x
        y = y + 1
        z = z * y
        y = y * 0
        y = y + w
        y = y + 3
        y = y * x
        z = z + y

        return z
    }

    func process(monad: Int) -> Int {
        var vars = [
            "w": 0,
            "x": 0,
            "y": 0,
            "z": 0
        ]

        var digits: [Int] = "\(monad)".compactMap { Int("\($0)") }

        if digits.contains(0) {
            return -1
        }

        for instruction in input {
            let parts = instruction.components(separatedBy: " ")
            let va = parts[1]
            let a = vars[va]!
            switch parts[0] {
            case "inp":
//                debug(vars)
                vars[va] = digits.removeFirst()
            case "add":
                let b = Int(parts[2]) ?? vars[parts[2]]!
                vars[va] = a + b
            case "mul":
                let b = Int(parts[2]) ?? vars[parts[2]]!
                vars[va] = a * b
            case "div":
                let b = Int(parts[2]) ?? vars[parts[2]]!
                vars[va] = a / b
            case "mod":
                let b = Int(parts[2]) ?? vars[parts[2]]!
                let t = a / b
                vars[va] = a - (t * b)
            case "eql":
                let b = Int(parts[2]) ?? vars[parts[2]]!
                vars[va] = a == b ? 1 : 0
            default:
                fatalError()
            }

//            print("\(instruction)  \tw: \(vars["w"]!), x: \(vars["x"]!), y: \(vars["y"]!), z: \(vars["z"]!)")
        }

        return vars["z"]!
    }

    public func part2() -> Int {
        for w1 in 1...9 {
            for w2 in 1...9 {
                for w3 in 1...4 {
                    for w4 in 6...9 {
                        for w5 in 4...9 {
                            for w6 in 1...6 {
                                for w7 in 1...2 { //
                                    for w8 in 1...9 {
                                        for w9 in 1...9 {
                                            for w10 in 1...9 {
                                                for w11 in 1...8 {
                                                    for w12 in 1...9 {
                                                        for w13 in 1...9 {
                                                            for w14 in 1...9 {
                                                                let monad = Int("\(w1)\(w2)\(w3)\(w4)\(w5)\(w6)\(w7)\(w8)\(w9)\(w10)\(w11)\(w12)\(w13)\(w14)")!

                                                                let r = process2(monad: monad)
                                                                if r == 0 {
                                                                    return monad
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return -1
    }
}
