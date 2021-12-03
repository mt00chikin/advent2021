//
//  Day3Solver.swift
//  Advent2021
//
//  Created by Thompson,Matthew on 12/3/21.
//

import Foundation

class Day3Solver {
    let input: [String]
    init(input: [String]) {
        self.input = input
    }

    func findGammaAndEpsilon() -> (gamma: String, epsilon: String) {
        let grid = input.map { Array($0) }
        let length = grid.map { $0.count }.max() ?? .zero

        var gamma: String = ""
        var epsilon: String = ""
        for i in 0..<length {
            let items = grid.map { String($0[i]) }
            let counts = items.reduce(into: [:]) { $0[$1, default: 0] += 1 }
            if counts["0"]! > counts["1"]! {
                gamma.append("0")
                epsilon.append("1")
            } else {
                gamma.append("1")
                epsilon.append("0")
            }
        }

        print("Gamma: \(gamma). Epsilon \(epsilon)")
        return (gamma, epsilon)
    }

    func determineOxygenGeneratorRating() -> String {
        var results: [String] = input
        var index = 0
        repeat {
            let bits = results.map { String($0[$0.index($0.startIndex, offsetBy: index)]) }
            let counts = bits.reduce(into: [:]) { $0[$1, default: 0] += 1 }
            let bitCriteria: String
            if counts["1"]! >= counts["0"]! {
                // Grab all results that have a 1 at the current index
                bitCriteria = "1"
            } else {
                bitCriteria = "0"
            }

            results = results.filter({ row in
                String(row[row.index(row.startIndex, offsetBy: index)]) == bitCriteria
            })

            index = index + 1
        } while results.count > 1

        return results.first!
    }

    func determineCO2ScrubberRating() -> String {
        var results: [String] = input
        var index = 0
        repeat {
            let bits = results.map { String($0[$0.index($0.startIndex, offsetBy: index)]) }
            let counts = bits.reduce(into: [:]) { $0[$1, default: 0] += 1 }
            let bitCriteria: String
            if counts["0"]! <= counts["1"]! {
                // Grab all results that have a 1 at the current index
                bitCriteria = "0"
            } else {
                bitCriteria = "1"
            }

            results = results.filter({ row in
                String(row[row.index(row.startIndex, offsetBy: index)]) == bitCriteria
            })

            index = index + 1
        } while results.count > 1

        return results.first!
    }
}
