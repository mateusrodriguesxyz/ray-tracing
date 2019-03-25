//
//  PixelSet.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation

public struct PixelSet {
    
    private let columns: Int
    private let rows: Int
    private(set) var array: [Pixel]
    
    public var width: Int {
        return columns
    }
    
    public var height: Int {
        return rows
    }
    
    public init(width: Int, height: Int, initialValue: Pixel) {
        self.columns = width
        self.rows = height
        array = .init(repeating: initialValue, count: rows*columns)
    }
    
    public subscript(column: Int, row: Int) -> Pixel {
        get {
            precondition(column < columns, "Column \(column) Index is out of range. PixelSet(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. PixelSet(columns: \(columns), rows:\(rows))")
            return array[row*columns + column]
        }
        set {
            precondition(column < columns, "Column \(column) Index is out of range. PixelSet(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. PixelSet(columns: \(columns), rows:\(rows))")
            array[row*columns + column] = newValue
        }
    }
    
    mutating func forEach(_ closure: (Int, Int) -> Pixel) {
        for i in 0..<self.columns {
            for j in 0..<self.rows {
                self[i, j] = closure(i, j)
            }
        }
    }
    
}
