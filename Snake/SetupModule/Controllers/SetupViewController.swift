//
//  SetupViewController.swift
//  Snake
//
//  Created by Vadim on 16.08.2023.
//

import UIKit

class SetupViewController: UIViewController {
    
    private var mainSetupView: MainSetupView? {
        view as? MainSetupView
    }
    
    override func loadView() {
        self.view = MainSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    @objc func levelButtonTapped(sender: UIButton) {
        var gameDetails = GameDetails(cols: 0, rows: 0, toNextLevel: 0)
        
        switch sender.tag {
        case 0:
            gameDetails = GameDetails(cols: 8, rows: 8, toNextLevel: 10)
        case 1:
            gameDetails = GameDetails(cols: 10, rows: 14, toNextLevel: 10)
        case 2:
            gameDetails = GameDetails(cols: 12, rows: 18, toNextLevel: 10)
        default:
            print("Error Level Button")
        }
        
        let mainViewController = MainViewController(gameDetails: gameDetails)
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
    
}
