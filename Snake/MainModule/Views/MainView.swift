//
//  MainView.swift
//  Snake
//
//  Created by Vadim on 03.04.2023.
//

import UIKit

protocol BoardProtocol: AnyObject {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction)
}

class MainView: UIView {
    
    weak var boardDelegate: BoardProtocol?
    
    private var gameDetails: GameDetails?
    private var boardView = BoardView()
    
    let scoreLabel = UILabel()
    let nextLevelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gameDetails: GameDetails) {
        self.init()
        self.gameDetails = gameDetails
        
        self.boardView = BoardView(cols: gameDetails.cols, rows: gameDetails.rows)
        
        addSwipe()
        
        backgroundColor = .white
        
        configureBoardView()
        configureScoreLabel()
        configurenextLevelLabel()
    }
    
    private func configureBoardView() {
        addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func configureScoreLabel() {
        scoreLabel.text = "Score: 10"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    private func configurenextLevelLabel() {
        nextLevelLabel.text = "Next Level: 10"
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextLevelLabel)
        NSLayoutConstraint.activate([
            nextLevelLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10),
            nextLevelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

//MARK: - UISwipeGestureRecognizer

extension MainView {
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        let location = sender.location(in: self)
        
        if boardView.frame.contains(location) {
            boardDelegate?.swipeGesture(direction: sender.direction)
        }
    }
}
