//
//  GameTimer.swift
//  Snake
//
//  Created by Vadim on 07.04.2023.
//

import Foundation

protocol TimerProtocol: AnyObject {
    func timeAction()
}

class GameTimer {
    
    weak var timerDelegate: TimerProtocol?
    
    private var timer = Timer()
    
    private var timeInterval = 0.3
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self, selector: #selector(timerAction),
                                     userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        timerDelegate?.timeAction()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func speedIncrease() {
        timeInterval = 0.2
        stopTimer()
        startTimer()
    }
}
