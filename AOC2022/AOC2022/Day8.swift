//
//  Day8.swift
//  AOC2022
//
//  Created by Matthew Hobbs on 08/12/2022.
//

import Foundation

struct Day8 {
}

extension Day8 {
    struct Part1 {
        
        
        static func run(_ lines: [String]) -> Int {
            print("Running \(type(of: self))" )
            let trees = lines
                .map { line in
                    return line
                        .map { height in Int(String(height))! }
                }
            
            let forest = Forest(trees: trees)
            print("visibleTreeCount \(forest.visibleTreeCount)")
                
            return 0
        }
    }
    
    struct Part2 {
        
        
        static func run(_ lines: [String]) -> Int {
            print("Running \(type(of: self))" )
            let trees = lines
                .map { line in
                    return line
                        .map { height in Int(String(height))! }
                }
            
            let forest = Forest(trees: trees)
            print("scenicScore \(forest.scenicScore)")
                
            return 0
        }
    }

    
    struct Forest {
        let trees: [[Int]]
        
        var height: Int {
            return trees.count
        }
        
        var width: Int {
            return trees[0].count
        }
        
        var visibleTreeCount: Int  {
            return trees
                .enumerated()
                .reduce(0) { acc, row in
                    return acc +
                    row.element
                        .enumerated()
                        .filter { col in
                            return isVisible(x: col.offset, y: row.offset)
                        }
                    .count
                }

        }
        
        var scenicScore: Int  {
            return trees
                .enumerated()
                .reduce(0) { acc, row in
                    return max(acc,
                    row.element
                        .enumerated()
                        .reduce(0) { acc, col in
                            let score = scenicScore(x: col.offset, y: row.offset)
                            return max(acc, score)
                        }
                    )
                }

        }

        
        func isVisible(x: Int, y: Int) -> Bool {
            let height = trees[y][x]
            return isOnEdge(x: x, y: y)
            || isVisibleFromLeft(x: x, y: y, treeHeight: height)
            || isVisibleFromRight(x: x, y: y, treeHeight: height)
            || isVisibleFromTop(x: x, y: y, treeHeight: height)
            || isVisibleFromBottom(x: x, y: y, treeHeight: height)
        }
        
        func treesOnLeft(_ x: Int, _ y: Int) -> [Int] {
            return Array(trees[y][0..<x])
        }
        
        func treesOnRight(_ x: Int, _ y: Int) -> [Int] {
            return Array(trees[y][x+1..<width])
        }
        
        func treesAbove(_ x: Int, _ y: Int) -> [Int] {
            return trees[0..<y].map { $0[x] }
        }
        
        func treesBelow(_ x: Int, _ y: Int) -> [Int] {
            return trees[y+1..<height].map { $0[x] }
        }

        func isVisibleFromLeft(x: Int, y: Int, treeHeight: Int) -> Bool {
            return treesOnLeft(x, y).allLessThan(treeHeight)
        }
        
        func isVisibleFromRight(x: Int, y: Int, treeHeight: Int) -> Bool {
            return treesOnRight(x, y).allLessThan(treeHeight)
        }

        func isVisibleFromTop(x: Int, y: Int, treeHeight: Int) -> Bool {
            return treesAbove(x, y).allLessThan(treeHeight)
        }

        func isVisibleFromBottom(x: Int, y: Int, treeHeight: Int) -> Bool {
            return treesBelow(x, y).allLessThan(treeHeight)
        }
        
        func scenicScore(x: Int, y: Int) -> Int {
            let height = trees[y][x]
            return scenicScoreLeft(x: x, y: y, treeHeight: height) *
            scenicScoreAbove(x: x, y: y, treeHeight: height) *
            scenicScoreRight(x: x, y: y, treeHeight: height) *
            scenicScoreBelow(x: x, y: y, treeHeight: height)
        }
        
        func scenicScoreLeft(x: Int, y: Int, treeHeight: Int) -> Int {
            return treesOnLeft(x, y)
                .reversed()
                .countElementsLessThan(treeHeight)
        }
        
        func scenicScoreRight(x: Int, y: Int, treeHeight: Int) -> Int {
            return treesOnRight(x, y)
                .countElementsLessThan(treeHeight)
        }

        func scenicScoreAbove(x: Int, y: Int, treeHeight: Int) -> Int {
            return treesAbove(x, y)
                .reversed()
                .countElementsLessThan(treeHeight)
        }

        func scenicScoreBelow(x: Int, y: Int, treeHeight: Int) -> Int {
            return treesBelow(x, y)
                .countElementsLessThan(treeHeight)
        }
        
        func isOnEdge(x: Int, y: Int) -> Bool {
            return x == 0 || x == width - 1 || y == 0 || y == height - 1
        }
        
    }
}

extension Array where Element == Int {
    
    func allLessThan(_ value: Int) -> Bool {
        return self.allSatisfy { $0 < value }
    }
    
    func countElementsLessThan(_ value: Int) -> Int {
        return (self
            .enumerated()
            .first(where: { $0.element >= value })?.offset ?? count - 1) + 1

    }
}

extension Int {
    func debug(_ label: String) -> Int {
        print("\(label): \(self)")
        return self
    }
}
