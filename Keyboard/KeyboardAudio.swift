//
//  KeyboardAudio.swift
//  Keyboard
//
//  Created by Alex Appadurai on 04/04/22.
//

import Foundation
import AVFoundation


func playTextChangeAudio(){
    DispatchQueue.main.async {
        AudioServicesPlaySystemSound(1123)
    }
}

func playBackspaceAudio(){
    DispatchQueue.main.async {
        AudioServicesPlaySystemSound(1155)
    }
}
func playOtherAudio(){
    DispatchQueue.main.async {
        AudioServicesPlaySystemSound(1156)
    }
}
