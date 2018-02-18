//
//  ViewController.swift
//  Is Headphone Plugged In
//
//  Created by Sanjib Ahmad on 4/9/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var headphonePluggedInStateImageView: UIImageView!
    var timer: Timer?
    let deviceRequiredImage = UIImage(named: "device_required")
    let headphonePluggedInImage = UIImage(named: "headphone_plugged_in")
    let headphonePulledOutImage = UIImage(named: "headphone_pulled_out")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    headphonePluggedInStateImageView.image = headphonePluggedInImage
                    print("headphone plugged in")
                } else {
                    headphonePluggedInStateImageView.image = headphonePulledOutImage
                    print("headphone pulled out")
                }
                
            }
        } else {
            headphonePluggedInStateImageView.image = deviceRequiredImage
            print("requires connection to device")
        }
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.audioRouteChangeListener(_:)),
            name: NSNotification.Name.AVAudioSessionRouteChange,
            object: nil)
        

        
     /*   NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.audioStartedOrStopped(_:)),
            name: NSNotification.Name.AVAudioSessionSilenceSecondaryAudioHint,
            object: nil)*/
        
        let session = AVAudioSession.sharedInstance()
        do {
            // 1) Configure your audio session category, options, and mode
            // 2) Activate your audio session to enable your custom configuration
            try session.setActive(true)
        } catch let error as NSError {
            print("Unable to activate audio session:  \(error.localizedDescription)")
        }
        
        runTimer()
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let isOtherAudioPlaying = AVAudioSession.sharedInstance().isOtherAudioPlaying
        print(isOtherAudioPlaying)
    }
    
    @objc dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt

        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            headphonePluggedInStateImageView.image = headphonePluggedInImage
            print("headphone plugged in")
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            headphonePluggedInStateImageView.image = headphonePulledOutImage            
            print("headphone pulled out")
        default:
            break
        }
        
        
    }
    
    
 /*   @objc dynamic fileprivate func audioStartedOrStopped(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        print("Start")
        
    }*/

}

