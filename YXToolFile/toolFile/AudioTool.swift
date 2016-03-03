
//
//  AudioTool.swift
//  bluetooth
//
//  Created by paul-y on 16/2/1.
//  Copyright © 2016年 YinQiXing. All rights reserved.
//

import Foundation
import AVFoundation
class AudioTool: NSObject {
    static private var soundIDs = [String:SystemSoundID]()
    
    static private var players = [String:AVAudioPlayer]()
    /**
     播放音效
     */
    class func playAudioWith(filename : String){
    let  soundID  = soundIDs[filename]
        if soundID == nil{
            var mysoundID :SystemSoundID = 0
            let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
            if url == nil{
                return
            }
            AudioServicesCreateSystemSoundID(url!, &mysoundID)
            self.soundIDs[filename] = mysoundID
        }
        AudioServicesPlaySystemSound(soundIDs[filename]!)
    }
    /**
     销毁音效
     */
    class func disposeAudioWithFilename(filename:String){
        if let soundId = soundIDs[filename]{
            AudioServicesDisposeSystemSoundID(soundId)
            self.soundIDs.removeValueForKey(filename)
        }
  
    }
    /**
    根据音乐文件名称播放音乐
    */
    class func playMusicWith(filename:String){
        var player = self.players[filename]
        if player == nil{
            // 2.1根据文件名称加载音效URL
            let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
            if url == nil{
                return
            }
            
            do{
                 player =  try   AVAudioPlayer(contentsOfURL: url!)
            } catch{
                
            }
            if  !player!.prepareToPlay(){
                return
            }
            // 允许快进
            player!.enableRate = true
            player!.rate = 3
            
            self.players[filename] = player!
            
        }
        // 3.播放音乐
        if !player!.playing{
            player!.play()
        }
       
       
    }

    /**
    根据音乐文件名称暂停音乐
    */
    class func pauseMusicWith(filename:String){
        if  let player = self.players[filename] {
            if player.playing{
                player.pause()
            }
        }
    }
    
    /**
     根据音乐文件名称停止音乐
     */
    class func stopMusicWith(filename:String){
        if  let player = self.players[filename] {
            player.stop()
            self.players.removeValueForKey(filename)
        }
    }
}

















