# Advent of Code 2021

Solutions to [the 2021 edition of Advent of Code](https://adventofcode.com/2021) in Swift.

## Day 0

Spent some time figuring out a good way to do this in Swift without having to manage a bunch
of Xcode projects/targets _and_ still have the ability to use external dependencies using the
Swift Package Manager.

I chose the excellent [swift-sh](https://github.com/mxcl/swift-sh) to make it easy to run/compile
standalone scripts with external dependencies (such as [swift-algorithms](https://github.com/apple/swift-algorithms)).

## Day 1: Sonar Sweep

Used a couple of helpful functions from [swift-algorithms](https://github.com/apple/swift-algorithms)
to massage and process the data without writing a bunch of boilerplate.

## Day 2: Dive!

Fairly straightforward, started with a quick 'n dirty solution, later changed it to use a bit more functional approach
using map/reduce and avoiding local state/side effects.

## Day 3: Binary Diagnostic

A broken dishwasher limited the time I had availble to spend on this, hence the copiuous duplication in part 2.

## Day 4: Giant Squid

Trickiest part was to figure out the correct halting condition in part 2. Much love for Swift's `typealias` so I don't
have to mentally deal with types like `[[[Int]]]`.

## Day 5: Hydrothermal Venture

TIL: `signum()` is awesome. In the end part 2 is actually cleaner than part 1. I could have just used that with the
additional constraint of filtering out diagonals for part 1.

## Day 6: Lanternfish

Did the first part the naive way, which of course didn't work for part 2. My new favorite Swift toy is for sure
`myDict[myKey, default: 0] += 1` where you don't have to worry about dealing with `nil`s.

## Day 7: The Treachery of Whales

For part 1 the median sufficed, but for part 2 I (initially) used the average, but the rounding was off
such that the sample input would fail, but the actual puzzle input would pass. Because of the limited
input size in the end I calculated the fuel cost for all position between the first and the last crab,
which ran quick enough. TIL: Triangular numbers.

## Day 8: Seven Segment Search

Good fun, I was already expecting part 2 to require decoding the numbers, but did solve part 1 the simple
way, by simply counting string lengths. Part 2 required writing down the patterns, but then it was fairly
easy by process of elimination. Not too happy with the `inout` mutable state and force unwraps, but it works.

## Day 9: Smoke Basin

Nice to see a MS Paint style floodfill in action.

## Day 10: Syntax Scoring

Push and pop all the way.

## Day 11: Dumbo Octopus

Part 2 surprisingly easy after part 1. Only difference is not halting after 100 steps, but when the grid is
all zeros.