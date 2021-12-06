#!/usr/bin/swift sh
import Foundation

func simulateDay(_ population: [Int: Int]) -> [Int: Int] {
    var newPopulation = [Int: Int]()
    
    // Decrease timer
    population.forEach({ (key, value) in
        newPopulation[key - 1] = value
    })
    
    // Birth new fish
    if let birthingFish = newPopulation[-1] {
        newPopulation.removeValue(forKey: -1)
        newPopulation[6, default: 0] += birthingFish
        newPopulation[8, default: 0] += birthingFish
    }
    
    return newPopulation
}


var population = [Int:Int]()
try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)[0]
    .components(separatedBy: ",")
    .compactMap({ Int($0) })
    .map({ population[$0, default: 0] += 1 })

for day in (1...256) {
    population = simulateDay(population)
}

let total = population
    .map({ $0.value })
    .reduce(0, +)

print(total)
