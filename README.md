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