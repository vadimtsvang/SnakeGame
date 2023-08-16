//
//  GameField.swift
//  Snake
//
//  Created by Vadim on 24.07.2023.
//

import Foundation

class GameField {
    private var sizeField: GameCell
    
    var size: GameCell {
        sizeField
    }
    
    init(cols: Int, rows: Int) {
        sizeField = GameCell(col: cols, row: rows)
    }
}
