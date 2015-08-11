//
//  ViewController.swift
//  mimicky
//
//  Created by Naveen Pandey on 03/05/15.
//  Copyright (c) 2015 navlabs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true;
        recordButton.enabled=true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
       
        //Record user's voice
        recordingInProgress.text="recording..."
        recordButton.enabled=false;
        stopButton.hidden=false;
        
        
        let dirPath=NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask , true)[0] as! String
        let currentDate=NSDate()
        let currentDateFormatter=NSDateFormatter()
        currentDateFormatter.dateFormat="ddMMyyyy-HHmmss"
        let recordingName=currentDateFormatter.stringFromDate(currentDate)+".wav"
        let pathArray=[dirPath,recordingName]
        let filePath=NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        //Setup audio session
        var session=AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Initialize and prepare recorder
        audioRecorder=AVAudioRecorder(URL:filePath,settings:nil, error:nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled=true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecordingAudio(sender: UIButton) {
        
        //Stop recording session
        recordingInProgress.text="Tap To Record";
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio=RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent!)
            
            //Move to teh next scene and pass teh recorded audio data
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            println("Recording was not successful")
            recordButton.enabled=true
            stopButton.hidden=true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC:PlaySoundsViewController=segue.destinationViewController as! PlaySoundsViewController
            let data=sender as! RecordedAudio
            playSoundsVC.receivedAudio=data
            
        }
        
    }

  
    
    
}

