import AdventKit
import Algorithms
import AppKit
import Foundation

class Dice {
    var next = 0
    var numberOfRolls = 0

    func roll1() -> Int {
        numberOfRolls += 1
        next = next % 100 + 1
        return next
    }

    func roll3() -> Int {
        return roll1() + roll1() + roll1()
    }
}

class Player {
    var position: Int

    init(position: Int) {
        self.position = position
    }

    var score = 0

    func move(_ spaces: Int) {
        position = (position + spaces - 1) % 10 + 1
        score += position
    }
}

struct State {
    let positions: [Int]
    let scores: [Int]
    let player1IsUp: Bool
}

extension State: Hashable {}

public class Puzzle {
    let startP1: Int
    let startP2: Int
    public init(input: String) {
        let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        startP1 = Int(lines[0].components(separatedBy: ": ")[1])!
        startP2 = Int(lines[1].components(separatedBy: ": ")[1])!
    }

    public func part1() -> Int {
        let p1 = Player(position: startP1)
        let p2 = Player(position: startP2)
        let dice = Dice()
        while true {
            p1.move(dice.roll3())
            if p1.score >= 1000 { break }
            p2.move(dice.roll3())
            if p2.score >= 1000 { break }
        }
        return dice.numberOfRolls * min(p1.score, p2.score)
    }

    public func part2() -> Int {
        play(state: State(positions: [startP1, startP2], scores: [0, 0], player1IsUp: true))
            .values
            .max()!
    }

    var stateCache = [State: [Int: Int]]()
    func play(state: State) -> [Int: Int] {
        if let wins = stateCache[state] {
            return wins
        } else {
            let playerIndex = state.player1IsUp ? 0 : 1
            var wins = [Int: Int]()
            for d1 in 1 ... 3 {
                for d2 in 1 ... 3 {
                    for d3 in 1 ... 3 {
                        let newPos = (state.positions[playerIndex] + d1 + d2 + d3 - 1) % 10 + 1
                        let newScore = state.scores[playerIndex] + newPos
                        if newScore >= 21 {
                            wins[playerIndex, default: 0] += 1
                        } else {
                            var newPositions = state.positions
                            newPositions[playerIndex] = newPos
                            var newScores = state.scores
                            newScores[playerIndex] = newScore
                            let newState = State(positions: newPositions, scores: newScores, player1IsUp: !state.player1IsUp)
                            let _wins = play(state: newState)
                            wins[0, default: 0] += _wins[0, default: 0]
                            wins[1, default: 0] += _wins[1, default: 0]
                        }
                    }
                }
            }
            stateCache[state] = wins
            return wins
        }
    }
}
