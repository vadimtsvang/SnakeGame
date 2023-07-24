//
//  BoardView.swift
//  Snake
//
//  Created by Vadim on 13.03.2023.
//

import UIKit

class BoardView: UIView {
    
    private var cols = 0
    private var rows = 0
    private var cellSide: CGFloat = 0
    
    var snake: [SnakeCell] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var addPoint: CGPoint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / CGFloat(cols)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(cols: Int, rows: Int) {
        self.init()
        self.cols = cols
        self.rows = rows
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
        drawAddPoint()
        drawSnake()
    }
    
    //MARK: - Draw objects
    
    private func drawGrid() {
        
        let gridPath = UIBezierPath()
        
        for i in 0...rows {
            gridPath.move(to: CGPoint(x: 0, y: CGFloat(i) * cellSide))
            gridPath.addLine(to: CGPoint(x: CGFloat(cols) * cellSide, y: CGFloat(i) * cellSide))
            
        }
        
        for i in 0...cols {
            gridPath.move(to: CGPoint(x: CGFloat(i) * cellSide, y: 0))
            gridPath.addLine(to: CGPoint(x: CGFloat(i) * cellSide, y: CGFloat(rows) * cellSide))
            
        }
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        
        guard !snake.isEmpty, let snakeHead = snake.first else { return }
        
        SnakeColor.snakeHead.setFill()
        UIBezierPath(roundedRect: CGRect(x: CGFloat(snakeHead.col) * cellSide,
                                         y: CGFloat(snakeHead.row) * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.count {
            let cell = snake[i]
            UIBezierPath(roundedRect: CGRect(x: CGFloat(cell.col) * cellSide,
                                             y: CGFloat(cell.row) * cellSide,
                                             width: cellSide,
                                             height: cellSide),
                         cornerRadius: 5).fill()
        }
    }
    
    private func drawAddPoint() {
        guard let addPoint else { return }
        SnakeColor.addPoint.setFill()
        UIBezierPath(roundedRect: CGRect(x: addPoint.x * cellSide,
                                         y: addPoint.y * cellSide,
                                         width: cellSide,
                                         height: cellSide),
                     cornerRadius: 5).fill()
    }
}
