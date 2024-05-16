//
//  RandomIndexGenerator.swift
//  Blind75
//
//  Created by Sudhanva Paturkar on 16/05/24.
//

import Foundation

struct RandomIndexGenerator {
    private var indices: [Int]
    private var currentIndex: Int
    
    init(arraySize: Int) {
        self.indices = Array(0..<arraySize)
        self.currentIndex = arraySize
    }
    
    mutating func next() -> Int {
        if currentIndex >= indices.count {
            indices.shuffle()
            currentIndex = 0
        }
        let index = indices[currentIndex]
        currentIndex += 1

        return index
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    
}
