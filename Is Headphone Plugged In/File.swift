//
//  File.swift
//  Unplug
//
//  Created by yang xu on 2/18/18.
//  Copyright © 2018 Object Coder. All rights reserved.
//

import Foundation
import AVFoundation
var engine: AVAudioEngine!      //The Audio Engine
var player: AVAudioPlayerNode!  //The Player of the audiofile
var file = AVAudioFile()        //Where we're going to store the audio file
var timer: Timer?               //Timer to update the meter every 0.1 ms
var volumeFloat:Float = 0.0     //Where We're going to store the volume float

//installTap with a bufferSize of 1024 with the processingFormat of the current audioFile on bus 0
engine.mainMixerNode.installTap(onBus:0, bufferSize: 1024, format: file/*, block: <#AVAudioNodeTapBlock#>,.processingFormat*/) {
    (buffer : AVAudioPCMBuffer!, time : AVAudioTime!) in
    

    
    let dataptrptr = buffer.floatChannelData!           //Get buffer of floats
    let dataptr = dataptrptr.pointee
    let datum = dataptr[Int(buffer.frameLength) - 1]    //Get a single float to read
    
    //store the float on the variable
    self.volumeFloat = fabs((datum))
    
}

//Loop the audio file for demo purposes
player.scheduleBuffer(buffer, at: nil, options: AVAudioPlayerNodeBufferOptions.loops, completionHandler: nil)

engine.prepare()
do {
    try engine.start()
} catch _ {
}

player.play()


