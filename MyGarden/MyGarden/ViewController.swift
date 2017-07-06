//
//  ViewController.swift
//  MyGarden
//
//  Created by Daniel Burgner on 6/22/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Label: UILabel!
    var minutes = 5
    var seconds = 00
    var timer : Timer?
    var timerIsOn = false

    @IBAction func startButton(_ sender: Any) {
        if (timerIsOn == false) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTime)), userInfo: nil, repeats: true)
            timerIsOn = true
            
        }
    }
    @IBAction func stopButton(_ sender: Any) {
        timer?.invalidate()
        minutes = 5
        seconds = 00
        Label.text = String(format:"%i:%02i", minutes, seconds)
        timerIsOn = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }

    func appMovedToBackground() {
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTime() {
        if (seconds == 0) {
            minutes -= 1
            seconds = 59
        } else {
            seconds -= 1
        }
        Label.text = String(format:"%i:%02i", minutes, seconds)
        if ((minutes == 0) && (seconds == 0)) {
            timer?.invalidate()
            timerIsOn = false
        }
    }

}

