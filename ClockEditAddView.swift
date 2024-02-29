//
//  ClockEditView.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/8/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ClockEditAddView: View {
    
    @Query var clocks: [Clock];
    
    @Bindable var clock: Clock
    
    @Binding var currentClockName: String;
    @Binding var isSheetPresented: Bool;
    @Binding var isEdit: Bool;
    
    var editAddClock: (String, Int) -> Void;
    
    @State private var clockDays: String = "";
    @State private var clockHours: String = "";
    @State private var clockMinutes: String = "";
    @State private var clockSeconds: String = "";
    
    @State var newClockName: String = "";
    @State var isDurationInputSelected = true;
    @State var selectedDate = Date();
    
    @State var isClockNameUnique = true;
    @State var isTimeValid = false;
    
    var body: some View {
        
        VStack{
            
            HStack(){
                Text("\( isEdit ? "Edit clock: \(currentClockName)" : "Add new clock")")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 25, trailing: 0))
            
            HStack{
                
                VStack{
                    
                    HStack {
                        
                        TextField("\( isEdit ? clock.name : "New clock name")", text: $newClockName)
                            .onChange(of: newClockName){
                                
                            if clocks.contains(where: {$0.name == newClockName && $0.id != clock.id}){
                                isClockNameUnique = false;
                            } else {
                                isClockNameUnique = true;
                            }
                            
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                        
                        Picker("", selection: $isDurationInputSelected) {
                            Text("Duration").tag(true)
                            Text("Date Selection").tag(false)
                        }
                    }
                    
                    if !isClockNameUnique || (newClockName == "" && isEdit == false){
                        
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 15)
                            
                            Text("\(!isClockNameUnique ? "Clock named '\(newClockName)' already exists." : isEdit == false && newClockName == "" ? "New clock name cannot be empty" : "")")
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .layoutPriority(1)
                                .font(.footnote)
                            Spacer();
                            
                        }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        
                    }
                }
                .fixedSize()
                
                }
            
            if isDurationInputSelected {
                
                DurationInputView(clockDays: self.$clockDays, clockHours: self.$clockHours, clockMinutes: self.$clockMinutes, clockSeconds: self.$clockSeconds, isTimeValid: self.$isTimeValid)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                .onDisappear{
                    isTimeValid = false;
                }

            } else {
                
                HStack{
                    VStack {
                        MyDatePicker(selection: $selectedDate)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .fixedSize()
                            .onChange(of: selectedDate, {
                                if Int(selectedDate.timeIntervalSinceNow) <= 0 {
                                    isTimeValid = false;
                                } else {
                                    isTimeValid = true;
                                }
                            })

                        HStack {
                            if isTimeValid == false || Int(selectedDate.timeIntervalSinceNow) <= 0 {
                                Image(systemName: "exclamationmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 15)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                
                                Text("Picked date can not be less than current date.")
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .layoutPriority(1)
                                    .font(.footnote)
                            }
                        }

                    }

                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }

            
            HStack{
                Button(isEdit ? "Edit clock" : "Add clock"){
                
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
                        
                        newRemainingTime = Int(selectedDate.timeIntervalSinceNow)
                        if newRemainingTime < 0 {
                            isTimeValid = false;
                        }
                        
                    }
                    
                    if isClockNameUnique == true && isTimeValid == true {
                        if isEdit && newClockName == "" {newClockName = currentClockName}
                        editAddClock(newClockName, newRemainingTime);
                        isSheetPresented = false;
                    }
                    

                }
                
                Spacer()
                
                Button("Exit"){
                    isSheetPresented = false;
                }
            }
            }
            .frame(width: 500, height: 300)
            .padding(EdgeInsets(top: 0, leading: 100, bottom: 50, trailing: 100))
    }
    
}


