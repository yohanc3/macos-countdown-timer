//
//  ClockHeader.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/14/24.
//

import Foundation
import SwiftUI


struct ClockHeader: View{
    
    @Binding var currentClock: Clock?;
    
    var body: some View {
        HStack(spacing: 20){
            if var currentClock = self.currentClock, !currentClock.isCountOver{
                Text("Current timer name: \(currentClock.name)")
                
            }
        }
    }
}
