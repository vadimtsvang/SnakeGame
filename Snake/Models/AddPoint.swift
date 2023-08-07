//
//  AddPoint.swift
//  Snake
//
//  Created by Vadim on 21.03.2023.
//

import Foundation

class AddPoint {
    
    private var addPointCoordinate = GameCell(col: 1, row: 4)
    
    var coordinate: GameCell {
        addPointCoordinate
    }
    
    func randomizeAddPoint(snake: [GameCell], gameCell: GameCell) {
        func isOnSnake() -> Bool {
            for cell in snake {
                if cell.col == addPointCoordinate.col && cell.row == addPointCoordinate.row {
                    return true
                }
            }
            return false
        }
        
        while isOnSnake() {
            addPointCoordinate.col = Int.random(in: 1..<gameCell.col)
            addPointCoordinate.row = Int.random(in: 1..<gameCell.row)
        }
    }
}
