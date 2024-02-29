//
//  Clock.swift
//  count down timer
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation
import SwiftData

@Model
class Clock {
    
    var id: String;
    var name: String;
    var durationInSeconds: Int;
    var objectiveDate: Date;
    var isCountOver: Bool;
    var remainingTime: Int {
        get {
            let remainingTime = Int(objectiveDate.timeIntervalSinceNow);
            if remainingTime > 0 { return remainingTime }
            else { return 0 }
        }
        set{}
    }
    var isCurrentClock: Bool = false;
    
    init(name: String, durationInSeconds: Int){
        
        self.id = UUID().uuidString;
        self.name = name;
        self.durationInSeconds = durationInSeconds;
        self.objectiveDate = Date() + TimeInterval(durationInSeconds);
        self.isCountOver = false;
    }
    
    func endTimer(){
        self.isCountOver = true;
    }
    
    func editClock(name: String?, newRemainingTime: Int?){
        if let newName = name, let remainingTime = newRemainingTime{
            if remainingTime > 0 {
                self.objectiveDate = Date() + TimeInterval(remainingTime)
            }
            self.name = newName;
        }
        
    }
    
}
