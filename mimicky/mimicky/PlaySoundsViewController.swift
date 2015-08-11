//
//  PlaySoundsViewController.swift
//  mimicky
//
//  Created by Naveen Pandey on 03/05/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//


import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var filePathUrl=receivedAudio.filePathUrl
        audioPlayer=AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
        audioPlayer.enableRate=true
        audioEngine=AVAudioEngine()
        audioFile=AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        //Play audio sloooowly here...
        stopAndResetAudioEngine()
        playAudioWithRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        //Play audio fast here...
        stopAndResetAudioEngine()
        playAudioWithRate(2.0)
      
    }
    
    @IBAction func playChipmunks(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func playDarthVaderEffect(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playAudioWithVariablePitch(pitch:Float)
    {
       
        stopAndResetAudioEngine()
        
        var audioPlayerNode=AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        var changePitchEffect=AVAudioUnitTimePitch()
        changePitchEffect.pitch=pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
  
  
    func stopAndResetAudioEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithRate(rate:Float){
        audioPlayer.rate=rate
        audioPlayer.play()
        audioPlayer.currentTime=0.0
    }
    
}
