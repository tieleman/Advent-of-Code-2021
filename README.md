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

# Day 3: Binary Diagnostic

A broken dishwasher limited the time I had availble to spend on this, hence the copiuous duplication in part 2.

# Day 4: Giant Squid

Trickiest part was to figure out the correct halting condition in part 2. Much love for Swift's `typealias` so I don't
have to mentally deal with types like `[[[Int]]]`.

# Day 5: Hydrothermal Venture

TIL: `signum()` is awesome. In the end part 2 is actually cleaner than part 1. I could have just used that with the
additional constraint of filtering out diagonals for part 1.