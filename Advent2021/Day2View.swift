//
//  Day2View.swift
//  Advent2021
//
//  Created by Thompson,Matthew on 12/2/21.
//

import os.log
import SwiftUI

struct NavInstruction {
    enum Direction: String {
        case forward = "forward"
        case up = "up"
        case down = "down"
    }

    let direction: Direction
    let magnitude: Int

    init?(string: String) {
        let components = string.components(separatedBy: .whitespaces)
        guard components.count == 2 else { return nil }

        direction = Direction(rawValue: components[0])!
        magnitude = Int(components[1])!
    }
}

struct Coordinate: CustomStringConvertible {
    var x: Int
    var y: Int

    static var zero: Coordinate = .init(x: 0, y: 0)

    var description: String {
        "Coordinate: \(x), \(y)"
    }
}

struct Day2View: View {
    @State var partOneAnswer: Int?
    @State var partTwoAnswer: Int?

    let logger = Logger()

    var body: some View {
        VStack(spacing: 16) {
            Button("Solve part 1") {
                solvePartOne()
            }

            HStack(spacing: 4) {
                Text("Part one answer:")
                if let partOneAnswer = partOneAnswer {
                    Text("\(partOneAnswer)")
                }
            }

            Button("Solve part 2") {
                solvePartTwo()
            }

            HStack(spacing: 4) {
                Text("Part two answer:")
                if let partTwoAnswer = partTwoAnswer {
                    Text("\(partTwoAnswer)")
                }
            }
        }
    }

    private func solvePartOne() {
        let string = Day2Input.input
        let instructions = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap { NavInstruction(string: $0) }

        logger.debug("Evaluating \(instructions.count) instructions")

        var coordinate: Coordinate = .zero
        instructions.forEach { instruction in
            switch instruction.direction {
            case .forward:
                coordinate.x = coordinate.x + instruction.magnitude
            case .up:
                coordinate.y = coordinate.y - instruction.magnitude
            case .down:
                coordinate.y = coordinate.y + instruction.magnitude
            }
        }

        logger.debug("Final point \(coordinate)")

        partOneAnswer = coordinate.x * coordinate.y
    }

    private func solvePartTwo() {
        let string = Day2Input.input
        let instructions = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap { NavInstruction(string: $0) }

        logger.debug("Evaluating \(instructions.count) instructions")

        var aim: Int = .zero
        var coordinate: Coordinate = .zero
        instructions.forEach { instruction in
            switch instruction.direction {
            case .forward:
                coordinate.x = coordinate.x + instruction.magnitude
                coordinate.y = coordinate.y + (instruction.magnitude * aim)
            case .up:
                aim = aim - instruction.magnitude
            case .down:
                aim = aim + instruction.magnitude
            }
        }

        logger.debug("Final point \(coordinate)")

        partTwoAnswer = coordinate.x * coordinate.y
    }
}

struct Day2View_Previews: PreviewProvider {
    static var previews: some View {
        Day2View()
    }
}

struct Day2Input {
    static let input = """
forward 5
down 9
forward 2
up 2
forward 4
forward 4
up 5
down 3
forward 2
forward 9
down 7
forward 2
down 2
forward 1
up 9
forward 1
forward 4
up 5
down 9
forward 8
forward 3
up 1
down 2
down 3
forward 7
forward 2
up 3
forward 9
forward 9
down 3
up 8
forward 5
forward 7
forward 2
down 7
forward 5
down 4
up 7
forward 8
forward 1
down 3
down 1
forward 6
up 7
forward 6
down 3
forward 9
forward 6
up 3
down 1
forward 8
up 7
down 9
down 2
down 1
down 5
forward 4
down 8
forward 2
down 5
down 6
down 5
forward 5
down 8
up 8
forward 3
forward 4
forward 8
forward 9
down 2
forward 7
forward 3
forward 9
down 3
up 1
down 5
forward 2
down 9
down 2
down 5
down 2
down 9
up 3
forward 6
up 9
down 1
forward 8
up 6
down 1
forward 1
up 1
forward 3
down 8
down 1
down 9
forward 4
forward 1
down 3
forward 8
down 9
forward 7
up 6
down 8
down 6
down 8
down 7
down 1
down 8
down 1
forward 5
down 9
forward 4
down 2
forward 8
up 1
forward 7
down 7
down 6
forward 4
forward 6
down 2
down 2
up 7
down 2
up 9
forward 6
forward 3
down 8
forward 9
down 9
down 9
down 8
forward 2
forward 5
forward 8
forward 1
down 3
forward 1
forward 2
forward 9
up 5
forward 4
forward 2
down 6
forward 3
forward 7
forward 1
forward 8
down 7
forward 4
up 3
down 9
up 2
forward 2
forward 7
down 9
up 9
forward 9
up 8
up 7
down 8
down 9
forward 1
forward 5
up 7
down 3
up 9
forward 9
down 4
down 7
down 7
down 1
down 4
down 5
up 2
forward 2
forward 2
forward 6
down 7
forward 7
down 5
forward 8
down 7
forward 6
down 2
up 2
down 5
down 1
up 4
down 8
up 9
forward 1
down 9
down 6
down 8
up 7
up 1
forward 7
down 8
forward 1
down 4
down 2
forward 3
forward 6
forward 8
down 2
forward 7
forward 8
up 3
down 1
down 8
up 3
down 4
down 5
forward 6
forward 9
down 3
up 2
down 9
up 2
down 3
down 9
forward 4
forward 6
down 7
down 8
down 4
forward 7
up 2
down 5
up 3
down 5
up 1
up 1
forward 5
forward 9
down 9
up 4
up 4
up 8
up 5
forward 7
forward 6
up 6
down 5
forward 4
forward 3
up 6
down 6
forward 5
up 6
up 7
forward 1
forward 2
forward 5
down 3
forward 6
down 6
down 3
up 9
down 4
down 5
down 4
forward 1
down 1
forward 3
up 4
forward 1
forward 5
up 3
forward 6
forward 5
forward 9
forward 6
down 2
forward 2
down 1
down 4
forward 6
forward 8
down 8
up 5
forward 8
forward 3
forward 1
forward 3
forward 6
down 1
down 9
up 7
down 2
forward 6
down 4
down 7
down 5
forward 2
down 1
forward 2
forward 8
forward 4
up 3
down 1
forward 6
forward 3
down 3
down 9
forward 1
up 5
forward 3
forward 3
up 5
down 7
forward 8
up 5
forward 2
forward 2
down 6
up 8
up 5
forward 2
forward 1
down 9
forward 7
down 5
forward 3
down 3
down 5
down 5
up 7
down 8
forward 2
forward 4
forward 5
forward 1
down 6
forward 3
down 1
down 7
forward 3
forward 7
down 5
down 3
forward 6
down 3
down 2
down 4
down 9
forward 7
down 2
up 2
up 6
up 9
up 8
forward 9
down 1
forward 4
forward 2
forward 7
forward 2
down 8
down 3
forward 4
forward 6
down 8
forward 7
forward 6
up 3
down 6
down 1
down 3
down 8
down 2
down 7
down 9
forward 4
forward 7
forward 8
forward 5
forward 9
up 5
down 2
forward 9
forward 6
up 6
forward 7
down 2
down 3
forward 4
down 6
down 1
down 2
down 8
forward 3
down 3
forward 3
down 5
up 8
down 5
forward 8
down 1
forward 1
forward 4
forward 7
down 2
down 5
forward 5
down 8
forward 2
down 2
forward 5
forward 6
forward 4
down 7
up 7
down 1
forward 7
forward 8
down 6
up 7
forward 6
up 6
down 8
forward 5
forward 8
up 4
up 2
up 1
down 8
down 6
up 2
down 5
down 1
forward 5
forward 7
down 2
up 3
up 3
forward 9
down 1
forward 6
down 2
forward 2
down 1
down 9
forward 7
down 5
down 8
up 1
forward 1
down 7
forward 3
down 4
up 4
down 6
forward 1
forward 3
down 2
forward 3
forward 5
forward 6
up 2
up 9
forward 4
down 4
up 1
up 3
forward 8
forward 1
down 9
down 9
forward 2
down 1
up 9
up 3
up 1
up 5
forward 6
down 9
forward 6
forward 9
forward 6
forward 4
up 2
down 6
up 3
forward 3
forward 1
up 4
forward 7
down 9
down 3
forward 9
down 4
down 8
down 3
up 8
down 8
down 8
forward 2
forward 8
up 9
forward 2
up 6
forward 7
down 1
forward 5
forward 4
forward 1
forward 7
up 9
down 8
forward 1
up 5
forward 9
forward 2
forward 8
down 1
forward 7
down 2
up 8
down 6
up 9
up 3
down 6
forward 5
down 1
forward 1
forward 6
forward 6
up 1
forward 5
forward 1
up 2
forward 9
forward 6
down 3
up 1
forward 7
forward 2
down 1
forward 6
down 3
up 2
down 3
down 8
forward 4
down 2
up 7
down 6
up 5
down 7
forward 4
down 9
down 3
forward 2
up 5
up 4
forward 9
down 1
up 2
forward 4
down 9
down 8
forward 5
forward 2
down 5
forward 6
down 4
forward 7
forward 1
forward 6
down 3
down 9
forward 9
forward 2
forward 6
down 7
down 5
down 3
forward 7
down 3
down 3
down 4
down 4
down 7
down 7
down 7
up 7
up 9
up 7
up 3
up 4
down 9
down 4
up 3
forward 2
up 1
down 9
down 6
up 1
up 2
down 7
down 9
up 2
forward 7
down 4
forward 3
down 1
down 7
forward 7
up 7
forward 3
forward 1
forward 6
forward 2
down 9
forward 8
up 8
down 8
down 9
up 1
down 4
down 6
down 8
up 4
down 1
forward 1
forward 1
forward 4
forward 7
forward 1
down 4
forward 5
up 3
forward 4
down 5
down 1
up 2
down 7
forward 7
down 7
up 9
down 9
down 3
up 2
up 8
up 8
up 7
forward 7
forward 5
forward 3
forward 2
down 5
forward 4
forward 1
down 6
down 1
forward 8
down 6
down 3
down 5
down 9
down 3
forward 7
forward 6
down 6
forward 9
up 7
forward 3
up 5
down 5
down 5
forward 4
up 6
down 6
forward 3
up 2
forward 4
up 1
down 5
forward 6
forward 9
down 2
up 2
down 2
up 7
forward 3
up 2
forward 9
forward 5
down 5
down 7
down 8
down 6
up 9
up 5
forward 7
down 8
down 1
forward 7
up 2
forward 4
forward 2
up 9
down 8
forward 1
forward 7
down 2
down 3
down 6
down 3
forward 1
up 6
forward 8
down 9
down 9
forward 8
up 8
down 6
forward 4
up 1
forward 5
down 3
down 7
down 7
down 3
up 2
forward 4
down 9
forward 2
down 9
forward 9
forward 4
forward 5
down 4
forward 1
up 1
forward 4
up 3
up 4
forward 7
down 9
forward 6
down 1
down 1
down 2
down 4
forward 7
forward 8
forward 6
down 8
forward 2
down 3
up 5
forward 2
up 5
forward 8
down 8
down 8
up 8
forward 6
up 1
down 3
forward 6
down 1
forward 9
up 1
forward 7
forward 7
down 1
forward 5
forward 2
up 7
down 1
forward 2
down 4
forward 3
down 9
forward 6
up 5
forward 1
forward 5
down 7
forward 6
down 8
forward 9
down 1
forward 9
down 1
forward 5
up 9
forward 1
forward 6
forward 5
down 7
down 6
down 5
down 9
forward 9
down 2
down 8
down 8
forward 2
forward 3
forward 3
down 3
forward 8
forward 8
down 8
forward 1
up 1
forward 4
down 7
forward 1
up 2
forward 9
forward 1
down 6
up 9
down 3
down 1
up 1
up 6
up 7
forward 9
up 2
forward 4
up 8
down 6
forward 3
forward 7
down 6
down 5
down 3
forward 5
down 1
forward 2
forward 9
down 8
up 6
forward 3
forward 2
up 7
down 3
forward 5
forward 9
down 5
down 1
up 4
down 8
forward 1
forward 3
forward 3
down 2
forward 5
down 1
forward 2
up 3
forward 8
down 2
up 8
down 6
down 8
forward 4
down 4
up 7
up 6
down 7
forward 2
up 3
forward 3
down 8
forward 8
down 5
forward 5
down 3
up 7
down 1
down 2
up 8
down 6
up 6
down 7
forward 5
up 3
forward 7
forward 2
down 9
down 1
down 4
down 7
forward 9
up 7
forward 5
up 8
forward 8
up 1
forward 2
down 7
down 5
down 6
down 4
up 4
forward 5
forward 6
up 4
forward 8
forward 4
forward 3
up 5
down 6
up 4
forward 8
down 7
forward 3
down 2
down 7
down 5
down 4
forward 5
up 4
forward 4
down 7
down 3
down 9
down 7
forward 2
forward 1
down 7
down 8
forward 1
forward 2
down 5
up 1
down 1
forward 5
down 2
forward 9
forward 7
down 2
forward 6
forward 9
up 5
forward 3
up 5
forward 7
down 6
down 3
up 3
down 4
forward 2
up 4
forward 5
up 9
down 3
up 1
down 1
up 3
forward 4
forward 5
down 3
forward 5
down 6
down 2
forward 5
forward 3
down 7
down 8
forward 4
down 5
forward 7
forward 2
forward 7
down 7
up 1
forward 6
down 1
forward 1
down 4
forward 1
up 6
forward 8
forward 6
forward 7
up 6
up 7
up 2
down 9
forward 4
up 3
down 1
down 1
forward 3
down 4
down 6
down 8
forward 9
forward 6
down 1
forward 5
"""
}
