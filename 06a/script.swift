#!/usr/bin/swift sh
import Foundation

func simulateDay(_ population: [Int]) -> [Int] {
    var newFish = [Int]()
    let updatedPopulation = population.map { fish -> Int in
        let updatedFish : Int
        if fish == 0 {
            updatedFish = 6
            newFish.append(8)
        } else {
            updatedFish = fish - 1
        }
        return updatedFish
    }
    return updatedPopulation + newFish
}

var population = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)[0]
    .components(separatedBy: ",")
    .compactMap({ Int($0) })

for day in (1...80) {
    population = simulateDay(population)
}

print(population.count)
