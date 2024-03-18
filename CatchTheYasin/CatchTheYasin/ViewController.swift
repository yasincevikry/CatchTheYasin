//
//  ViewController.swift
//  CatchTheYasin
//
//  Created by Yasin Çevik on 18.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var yasinArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var yasin1: UIImageView!
    @IBOutlet weak var yasin2: UIImageView!
    @IBOutlet weak var yasin3: UIImageView!
    @IBOutlet weak var yasin4: UIImageView!
    @IBOutlet weak var yasin5: UIImageView!
    @IBOutlet weak var yasin6: UIImageView!
    @IBOutlet weak var yasin7: UIImageView!
    @IBOutlet weak var yasin8: UIImageView!
    @IBOutlet weak var yasin9: UIImageView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    scoreLabel.text = "Score : \(score)"
//        highscore check
    let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
    if storedHighScore == nil {
        highScore = 0
        highScoreLabel.text = "HighScore: \(highScore)"
    }
    if let newScore = storedHighScore as? Int{
        highScore = newScore
        highScoreLabel.text = "Highscore: \(highScore)"
    }
        
    yasin1.isUserInteractionEnabled = true
    yasin2.isUserInteractionEnabled = true
    yasin3.isUserInteractionEnabled = true
    yasin4.isUserInteractionEnabled = true
    yasin5.isUserInteractionEnabled = true
    yasin6.isUserInteractionEnabled = true
    yasin7.isUserInteractionEnabled = true
    yasin8.isUserInteractionEnabled = true
    yasin9.isUserInteractionEnabled = true
        
    let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
    yasin1.addGestureRecognizer(recognizer1)
    yasin2.addGestureRecognizer(recognizer2)
    yasin3.addGestureRecognizer(recognizer3)
    yasin4.addGestureRecognizer(recognizer4)
    yasin5.addGestureRecognizer(recognizer5)
    yasin6.addGestureRecognizer(recognizer6)
    yasin7.addGestureRecognizer(recognizer7)
    yasin8.addGestureRecognizer(recognizer8)
    yasin9.addGestureRecognizer(recognizer9)
        
        
    yasinArray = [yasin1,yasin2,yasin3,yasin4,yasin5,yasin6,yasin7,yasin8,yasin9]
    
    counter = 10
    timeLabel.text = String(counter)
        
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
    hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideYasin), userInfo: nil, repeats: true)
    hideYasin()
        
    }
    
    @objc func hideYasin(){
        
        for yasin in yasinArray{
            yasin.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(yasinArray.count - 1)))
        yasinArray[random].isHidden = false
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for yasin in yasinArray{
                yasin.isHidden = true
            }
            
//            highscore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highScore")
                
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideYasin), userInfo: nil, repeats: true)
               
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

