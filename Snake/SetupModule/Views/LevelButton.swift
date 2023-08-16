//
//  LevelButton.swift
//  Snake
//
//  Created by Vadim on 16.08.2023.
//

import UIKit

class LevelButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
    }
    
    private func configure() {
        backgroundColor = .orange
        layer.cornerRadius = 10
        tintColor = .white
        addTarget(nil, action: #selector(SetupViewController.levelButtonTapped), for: .touchUpInside)
    }
}
