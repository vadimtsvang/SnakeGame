//
//  ViewController.swift
//  Snake
//
//  Created by Vadim on 13.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView {
        view as! MainView
    }
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    
    private var timer = Timer()
    
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setDelegates()
        startTimer()
    }
    
    private func setDelegates() {
        mainView.joystickView.joystickDelegate = self
        mainView.boardView.boardDelegate = self
    }
    
    //MARK: - Timer Actions
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.3,
                                     target: self, selector: #selector(timerAction),
                                     userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        gameModel.checkEating()
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        if !gameModel.isOnBoard() || !gameModel.crashTest() {
            timer.invalidate()
        }
        
        updateUI()
    }
    
    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col, y: addPointModel.coordinate.row)
        mainView.boardView.setNeedsDisplay()
    }
}

//MARK: - BoardProtocol

extension MainViewController: BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .left: controlModel.direction = .left
        case .right: controlModel.direction = .right
        case .up: controlModel.direction = .up
        case .down: controlModel.direction = .down
        default:
            break
        }
    }
}

//MARK: - JoystickProtocol

extension MainViewController: JoystickProtocol {
    func changePointLocation(_ point: CGPoint) {
        controlModel.changeDirection(point)
    }
}
