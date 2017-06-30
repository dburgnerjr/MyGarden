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
    var seconds = 60
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
        seconds = 60
        Label.text = "\(seconds)"
        timerIsOn = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTime() {
        seconds -= 1
        Label.text = "\(seconds)"
    }

}

