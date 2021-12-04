import AdventKit
import Foundation

// MARK: - Ticket

class Ticket {
    var numbers: [(number: Int, marked: Bool)]
    let numberOfColums: Int
    let numberOfRows: Int

    var umarked: [Int] {
        numbers.filter { !$0.marked }.map { $0.number }
    }

    init(_ string: String) {
        let rows = string
            .components(separatedBy: .newlines)

        numberOfRows = rows.count

        numberOfColums = rows
            .first!
            .split(separator: " ", omittingEmptySubsequences: true)
            .count

        numbers = rows
            .joined(separator: " ")
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
            .map { ($0, false) }
    }

    func mark(number: Int) -> Bool {
        if let position = numbers.enumerated().first(where: { $0.element.number == number }) {
            numbers[position.offset].marked = true
            return checkForBingo(from: position.offset)
        }
        return false
    }

    func checkForBingo(from position: Int) -> Bool {
        // check row
        let row = position / numberOfColums
        let rowRange = (row * numberOfRows ..< (row + 1) * numberOfColums)
        let hasRowBingo = rowRange.reduce(true) { partial, current in
            partial && numbers[current].marked
        }
        if hasRowBingo {
            return true
        }

        // check column
        let column = position % numberOfColums
        let columnRange = stride(from: column, to: numberOfColums * numberOfRows, by: numberOfColums)
        let hasColumnBingo = columnRange.reduce(true) { partial, current in
            partial && numbers[current].marked
        }
        if hasColumnBingo {
            return true
        }

        return false
    }
}

// MARK: - Puzzle

public class Puzzle {
    let input: [String]
    let numbers: [Int]

    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
        numbers = self.input[0].components(separatedBy: ",").compactMap(Int.init)
    }

    public func part1() -> Int {
        let tickets = input.dropFirst().map(Ticket.init)
        for number in numbers {
            for ticket in tickets {
                if ticket.mark(number: number) {
                    return number * ticket.umarked.reduce(0, +)
                }
            }
        }
        fatalError()
    }

    public func part2() -> Int {
        var tickets = input.dropFirst().map(Ticket.init)
        for number in numbers {
            for ticket in tickets.enumerated().reversed() {
                if ticket.element.mark(number: number) {
                    tickets.remove(at: ticket.offset)
                }
                if tickets.isEmpty {
                    return number * ticket.element.umarked.reduce(0, +)
                }
            }
        }
        fatalError()
    }
}
