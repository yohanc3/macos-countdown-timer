//
//  ClockEditView.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/8/24.
//

import Foundation
import SwiftUI

struct ClockEditView: View {
    
    @State var newClockName: String = "";
    
    @Binding var currentClockName: String;
    @Binding var isEditSheetPresented: Bool;
    var editClock: (String, Int) -> Void;
    
    @State private var clockDays: String = "";
    @State private var clockHours: String = "";
    @State private var clockMinutes: String = "";
    @State private var clockSeconds: String = "";
    
    @State var isDurationInputSelected = true;
    
    @State var selectedDate = Date();
    @State var selectedTime = Date();
    
    var body: some View {
        
        
        VStack{
            
            HStack(){
                Text("\(currentClockName)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
            
            HStack{
                
                TextField("New clock name", text: $newClockName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Picker("", selection: $isDurationInputSelected) {
                    Text("Duration").tag(true)
                    Text("Date Selection").tag(false)
                }
                .pickerStyle(MenuPickerStyle())
                .fixedSize()
                
                
                
                }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            if isDurationInputSelected {
                // Duration input view
                DurationInputView(clockDays: self.$clockDays, clockHours: self.$clockHours, clockMinutes: self.$clockMinutes, clockSeconds: self.$clockSeconds)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            } else {
                // Date selection view
                
                HStack{
                    MyDatePicker(selection: $selectedDate)
                        .padding()
                        .fixedSize()
//                    DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                        .padding()
//                        .labelsHidden()
                }
                
            }
            
            HStack{
                Button("Edit Clock"){
                
                    var newRemainingTime = 0;
                    
                    if isDurationInputSelected {
                        
                        let clockDaysInt = Int(clockDays) ?? 0;
                        let remainingDaysInSec = (clockDaysInt * 24 * 60 * 60)
                        
                        let clockHoursInt = Int(clockHours) ?? 0;
                        let remainingHoursInSec = (clockHoursInt * 60 * 60);
                        
                        let clockMinutesInt = Int(clockMinutes) ?? 0;
                        let remainingMinutesInSec = (clockMinutesInt * 60)
                        
                        let remainingSecs = Int(clockSeconds) ?? 0;
                        
                        newRemainingTime = remainingDaysInSec + remainingHoursInSec + remainingMinutesInSec + remainingSecs;
                        
                    } else {
                        
//                        let selectedDateTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: selectedTime), minute: Calendar.current.component(.minute, from: selectedTime), second: 0, of: selectedDate) ?? selectedDate;
                        
                        newRemainingTime = Int(selectedDate.timeIntervalSinceNow)
                        
                    }
                    
                    editClock(newClockName, newRemainingTime);
                    isEditSheetPresented = false;
                }
                
                Spacer()
                
                Button("Exit"){
                    isEditSheetPresented = false;
                }
            }
            }
            .frame(width: 500, height: 300)
            .padding(EdgeInsets(top: 0, leading: 100, bottom: 50, trailing: 100))
    }
    
}


