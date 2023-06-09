//
//  GameModel.swift
//  Snake
//
//  Created by Vadim on 13.03.2023.
//

import Foundation

class GameModel {
    
    static let cols = 15
    static let rows = 15
    
    private var snake: SnakeModel?
    private var addPoint: AddPointModel?
    
    init() { }
    
    init(snake: SnakeModel, addPoint: AddPointModel) {
        self.snake = snake
        self.addPoint = addPoint
    }
    
    private func isOnSnake(col: Int, row: Int) -> Bool {
        guard let snake else { return true }
        for cell in snake.snake {
            if cell.col == col && cell.row == row {
                return true
            }
        }
        return false
    }
    
    func checkEating() {
        guard let snake, let addPoint else { return }
        if snake.snake[0].col == addPoint.coordinate.col &&
            snake.snake[0].row == addPoint.coordinate.row {
            snake.eatAddPoint()
            addPoint.randomizeAddPoint()
            while isOnSnake(col: addPoint.coordinate.col, row: addPoint.coordinate.row) {
                addPoint.randomizeAddPoint()
            }
        }
    }
    
    func isOnBoard() -> Bool {
        guard let snake else { return false }
        if snake.snake[0].row < 0 || snake.snake[0].row > GameModel.rows - 1 ||
            snake.snake[0].col < 0 || snake.snake[0].col > GameModel.cols - 1 {
            return false
        }
        return true
    }
    
    func crashTest() -> Bool {
        guard let snake else { return false }
        
        var snakeWithoutHead = snake.snake
        snakeWithoutHead.removeFirst()
        
        let head = snake.snake[0]
        if snakeWithoutHead.contains(where: {$0.col == head.col && $0.row == head.row}) {
            return false
        }
        return true
    }
}
