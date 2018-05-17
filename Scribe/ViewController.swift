//
//  ViewController.swift
//  Scribe
//
//  Created by Valentinas Mirosnicenko on 1/11/17.
//  Copyright © 2017 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var button: CircleButton!
    
    var AudioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        button.isHidden = false
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        textField.text = ""
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        button.isHidden = true
        
        requestSpeechAuth()
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.AudioPlayer = sound
                        self.AudioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error!")
                    }
                    
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error:\(error)")
                        } else {
                            let result = (result?.bestTranscription.formattedString)! as String
                            self.textField.text = result

                        }
                    }
                }
            }
        }
    }

}
