//
//  ViewController.swift
//  Snake
//
//  Created by Vadim on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let boardView = BoardView()
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        addSwipe()
        startTimer()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(boardView)
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        
    }
    
    //MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            view.addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            if snakeModel.movingDirection != .right {
                snakeModel.movingDirection = .left
            }
        case .right:
            if snakeModel.movingDirection != .left {
                snakeModel.movingDirection = .right
            }
        case .up:
            if snakeModel.movingDirection != .down {
                snakeModel.movingDirection = .up
            }
        case .down:
            if snakeModel.movingDirection != .up {
                snakeModel.movingDirection = .down
            }
        default:
            break
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc private func timerAction() {
        gameModel.checkEating()
        snakeModel.moveSnake()
        if !gameModel.isOnBoard() || gameModel.crashTest() {
            timer.invalidate()
        }
        
        updateUI()
    }
    
    private func updateUI() {
        boardView.snake = snakeModel
        boardView.addPoint = addPointModel
        boardView.setNeedsDisplay()
    }
}

//MARK: - Set Constraints

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            boardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}