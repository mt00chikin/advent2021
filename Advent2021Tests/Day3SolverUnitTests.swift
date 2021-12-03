//
//  Day3SolverUnitTests.swift
//  Advent2021Tests
//
//  Created by Thompson,Matthew on 12/3/21.
//

@testable import Advent2021
import XCTest

class Day3SolverUnitTests: XCTestCase {
    let solver = Day3Solver(input: Day3Input.input
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                                .components(separatedBy: .newlines))

    func testPartOnePerformance() throws {
        measure {
            solver.findGammaAndEpsilon()
        }
    }

    func testO2RatingPerformance() {
        measure {
            solver.determineOxygenGeneratorRating()
        }
    }

    func testCO2RatingPerformance() {
        measure {
            solver.determineCO2ScrubberRating()
        }
    }
}
