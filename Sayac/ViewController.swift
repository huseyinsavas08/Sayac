//
//  ViewController.swift
//  Sayac
//
//  Created by Hüseyin Savaş on 7.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var timer = Timer()
    var count = 0
    var timerCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @objc func timerCounter() {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("Başla", for: .normal)
            startStopButton.setTitleColor(.white, for: .normal)
        } else {
            timerCounting = true
            startStopButton.setTitle("Dur", for: .normal)
            startStopButton.setTitleColor(.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Zaman Sıfırlama", message: "Zamanı sıfırlamaya emin misiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Çık", style: .default))
        
        alert.addAction(UIAlertAction(title: "Evet", style: .destructive, handler: { _ in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("Başla", for: .normal)
            self.startStopButton.setTitleColor(.white, for: .normal)
        }))
        
        present(alert, animated: true)
    }
}
