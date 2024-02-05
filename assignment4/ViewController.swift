//
//  ViewController.swift
//  assignment4
//
//  Created by user247998 on 2/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateTime: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var startStopTimerOutlet: UIButton!
    
    @IBOutlet weak var countdownOutlet: UIDatePicker!
    
    var timeRemaining = 60.0
    var countdownTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the active date and time
        var dateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateDateTime), userInfo: nil, repeats: true)
        
        // start the app with no time remaining messageccccc
        timeRemainingLabel.text = ""
        startStopTimerOutlet.setTitle("Start Timer", for: .normal)
        
    }
    
    @objc func updateDateTime() {
        let currentDateTime = Date()
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: currentDateTime)
        
        dateTime.text = dateTimeString
        
        // check if time is AM or PM
        // change background
        if (dateTime.text!.hasSuffix("PM")) {
            view.backgroundColor = UIColor.orange
        } else {
            view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func startStopButton(_ sender: Any) {
        countdownTimer.invalidate()
        
        if (countdownOutlet.countDownDuration > 0 && startStopTimerOutlet.currentTitle == "Start Timer") {
            countdownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
            startStopTimerOutlet.setTitle("Stop Timer", for: .normal)
        } else if (countdownOutlet.countDownDuration > 0 && startStopTimerOutlet.currentTitle == "Stop Timer") {
            startStopTimerOutlet.setTitle("Start Timer", for: .normal)
            countdownTimer.invalidate()
        }
    }
    
    @objc func startCountdown() {
        if (timeRemaining > 0) {
            let countdownFormatter = DateComponentsFormatter()
            countdownFormatter.allowedUnits = [.hour, .minute, .second]
            countdownFormatter.unitsStyle = .positional
            countdownFormatter.zeroFormattingBehavior = .pad
            
            timeRemainingLabel.text = "Time Remaining: " + countdownFormatter.string(from: timeRemaining)!
            
            timeRemaining -= 0.1
        } else {
            timeRemainingLabel.text = "Time Remaining: 00:00:00"
            startStopTimerOutlet.setTitle("Start Timer", for: .normal)
            countdownTimer.invalidate()
            timeRemaining = countdownOutlet.countDownDuration
        }
    }
    
    @IBAction func countDownAction(_ sender: Any) {
        countdownTimer.invalidate()
        
        timeRemaining = countdownOutlet.countDownDuration
        
        let countdownFormatter = DateComponentsFormatter()
        countdownFormatter.allowedUnits = [.hour, .minute, .second]
        countdownFormatter.unitsStyle = .positional
        countdownFormatter.zeroFormattingBehavior = .pad
        
        timeRemainingLabel.text = "Time Remaining: " + countdownFormatter.string(from: timeRemaining)!
    }
}
