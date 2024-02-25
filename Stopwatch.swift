//
//  Stopwatch.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/4/24.
//

import Foundation

class Stopwatch: ObservableObject {
    
    @Published var counter: Int = 0;
    private var timer: Timer?;
    
    func start(newCounter: Int){
            
        self.counter = newCounter;
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        { _ in
            self.counter -=  1
        }
        
    }
    
    func stop(){
        self.timer?.invalidate();
        self.timer = nil;
    }
    
    func reset(){
        self.counter = 0;
        self.stop();
    }
    
    func resume(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.counter -=  1
        }
        self.start(newCounter: self.counter)
    }
}
