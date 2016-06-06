//
//  ViewController.swift
//  CrossAndCircle
//
//  Created by Michał Skalski on 28.05.2016.
//  Copyright © 2016 Michał Skalski. All rights reserved.
//  Music copyrights: http://www.bensound.com/royalty-free-music
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    enum StateOfGame {
        case Circle, Cross
        
        mutating func changeSign() {
            switch self {
            case .Circle:
                self = .Cross
            case .Cross:
                self = .Circle
            }
        }
    }
    
    @IBOutlet weak var circleOutlet: UIButton!
    @IBOutlet weak var crossOutlet: UIButton!
    
    
    
    var gameState = StateOfGame.Circle
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playMusic("bensound.mp3")
        selectTurn()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func selectTurn() {
        switch gameState {
        case .Circle:
            circleOutlet.selected = true
            crossOutlet.selected = false
        case .Cross:
            circleOutlet.selected = false
            crossOutlet.selected = true
            
            
        }
    }
    
    func playMusic(fileName: String) {
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file \(fileName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    
    @IBAction func buttonTouched(sender: UIButton) {
        switch gameState {
        case .Circle:
            sender.setTitle("O", forState: .Normal)
        case .Cross:
            sender.setTitle("X", forState: .Normal)
        }
        sender.enabled = false
        gameState.changeSign()
        selectTurn()
    }
    
    @IBAction func musicOnOff(sender: UIButton) {
        if audioPlayer.playing {
            sender.setImage(UIImage(named: "Mute_Icon"), forState: UIControlState.Normal)
            audioPlayer.pause()
            //audioPlayer.volume = 0.0
        } else {
            sender.setImage(UIImage(named: "speaker_icon"), forState: UIControlState.Normal)
            audioPlayer.play()
            //audioPlayer.volume = 1.0
        }
    }
    @IBAction func resetButtonTouched(sender: UIButton) {
        gameState = .Circle
        selectTurn()
        
        for subview in self.view.subviews {
            if subview.tag > 0 {
                //(subview as! UIButton).enabled = true
                (subview as! UIButton).setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
}

