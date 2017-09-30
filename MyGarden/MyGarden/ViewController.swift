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
    var minutes = 0
    var seconds = 00
    var timer : Timer?
    var timerIsOn = false
    var plantDied = false
    var menuShowing = false
    var harvestPlant = false

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var menuView: UIView!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    
    @IBAction func startButton(_ sender: Any) {
        if (plantDied == true) {
            let alertController = UIAlertController(title: "Sorry!", message:
                "Please reset your timer.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        } else if ((timerIsOn == false) && ((minutes == 0) && (seconds == 0))) {
            let alertController = UIAlertController(title: "Timer is at 0:00", message:
                "Please set your timer.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        } else if (timerIsOn == false) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTime)), userInfo: nil, repeats: true)
            timerIsOn = true
            startButton.isHidden = true
            stopButton.isHidden = false
        }
    }
    @IBAction func stopButton(_ sender: Any) {
        timer?.invalidate()
        minutes = 0
        seconds = 00
        Label.text = String(format:"%i:%02i", minutes, seconds)
        timerIsOn = false
        startButton.isHidden = false
        stopButton.isHidden = true
        if (plantDied == true) {
            plantDied = false
        }
        if (harvestPlant == true) {
            harvestPlant = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 5
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        startButton.isHidden = false
        stopButton.isHidden = true
    }
    
    @IBAction func setTimerOneMin(_ sender: Any) {
        minutes = 1
        seconds = 00
        Label.text = String(format:"%i:%02i", minutes, seconds)
        leadingConstraint.constant = -200
        menuShowing = !menuShowing
    }

    @IBAction func setTimerFiveMin(_ sender: Any) {
        minutes = 5
        seconds = 00
        Label.text = String(format:"%i:%02i", minutes, seconds)
        leadingConstraint.constant = -200
        menuShowing = !menuShowing
    }

    @IBAction func setTimerTenMinutes(_ sender: Any) {
        minutes = 10
        seconds = 00
        Label.text = String(format:"%i:%02i", minutes, seconds)
        leadingConstraint.constant = -200
        menuShowing = !menuShowing
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing) {
            leadingConstraint.constant = -200
        } else {
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }

    func appMovedToBackground() {
        if (timerIsOn == true) {
            timer?.invalidate()
            let alertController = UIAlertController(title: "Sorry!", message:
                "Your plant died on you.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
            timerIsOn = false
            plantDied = true
            stopButton.isHidden = false
        }
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
            let alertController = UIAlertController(title: "Congratulations!", message:
                "You can harvest your plant.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
            harvestPlant = true
        }
    }

}

