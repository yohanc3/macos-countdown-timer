//
//  File.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/29/24.
//

import Foundation
import SwiftUI

struct ClockOverSheet: View {
    
    @Binding var isClockRecapitulationPresented: Bool;
    @Binding var clock: Clock;
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Timer finished");
            }
            HStack{
                Text("Timer finished on \(clock.objectiveDate.formatted(.dateTime.day().month().year().hour().minute().second()))")
            }
        }
        
    }
}
