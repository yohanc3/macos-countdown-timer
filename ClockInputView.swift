//
//  ClockInputView.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/3/24.
//

import Foundation
import SwiftUI

struct ClockInputView: View {
    
    @Binding var isCreateSheetPresented: Bool;
    
    @State private var clockName: String = "";
    @State private var clockDays: Int = 0;
    @State private var clockHours: Int = 0;
    @State private var clockMinutes: Int = 0;
    @State private var clockSeconds: Int = 0;
    
    var addClock: (ClockType) -> Void;
    
    var body: some View {
        VStack{
            TextField("Clock name", text: $clockName)
                .padding()
            HStack{
                Section(){
                    TextField("Days", value: $clockDays, formatter: NumberFormatter())
                }
                .textFieldStyle(PlainTextFieldStyle())
                .padding(3)
                TextField("Hours", value: $clockHours, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(3)
                TextField("Minutes", value: $clockMinutes, formatter: NumberFormatter())
                    .padding(3)
                TextField("Seconds", value: $clockSeconds, formatter: NumberFormatter())
                    .padding(3)
            }
            
            HStack{
                Button("Create Clock"){
                    let totalSeconds = (clockDays * 24 * 60 * 60) + (clockHours * 60 * 60) + (clockMinutes * 60) + clockSeconds
                    let newClock: ClockType = Clock(name: clockName, durationInSeconds: totalSeconds)
                    addClock(newClock)
                    isCreateSheetPresented = false;
                }
                Button("Exit"){
                    isCreateSheetPresented = false;
                }
            }
        }
    }
}
