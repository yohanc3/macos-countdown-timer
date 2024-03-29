//
//  ContentView.swift
//  todo-list
//
//  Created by Yohance Williams on 1/30/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    @Query var clocks: [Clock];
    
    @Binding var currentClock: Clock?;
    @Binding var currentClockId: String;
    @Binding var clockListId: UUID;
    
    var addClock: (String, Int) -> Void;
    var deleteClock: (Clock) -> Void;
    var editClock: (String, Int) -> Void;
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isTimerRunning: Bool = true;
    @State var isClockOverSheetPresented: Bool = false;
    
    @State var formattedTimer: TimeConverter? = nil;
    
    @State var formattedTime: String = "00:00:00:00";
    
    var body: some View {
            
        VStack(spacing: 20) {
            
            if let currentClock = self.currentClock{
                ZStack(){
                    
                    Text("\(formattedTime)")
                        .font(Font.custom("Digital-7", size: 285))
                        .foregroundStyle(Color("Red"))
                        .multilineTextAlignment(.center)
                        .blur(radius: 8.0)
                    Text("\(formattedTime)")
                        .font(Font.custom("Digital-7", size: 285))
                        .foregroundStyle(Color("LightRed"))
                        .multilineTextAlignment(.center)
                        .onReceive(timer){ _ in
                            if let formattedTimer = self.formattedTimer, formattedTimer.remainingTime > 0 {
                                formattedTimer.handleSecondsDecrease();
                                self.formattedTime = formattedTimer.formattedTime;
                            }
                            else {
                                isClockOverSheetPresented = true;
                                stopTimer();
                            }
                        }
                        .onAppear(){
                            
                            if let currentClock = self.currentClock{
                                    self.formattedTimer = ClockToTextConverter(clock: currentClock);
                                if let formattedTimer = self.formattedTimer {
                                    self.formattedTime = formattedTimer.formattedTime;
                                }
                            }
                        }
                        .onChange(of: currentClockId){
                            if let currentClock = self.currentClock, currentClock.remainingTime > 0 {
                                
                                isClockOverSheetPresented = false;
                                
                                if isTimerRunning == false {
                                    startTimer();
                                }
                                
                                self.formattedTimer = ClockToTextConverter(clock: currentClock);
                                if let formattedTimer = self.formattedTimer {
                                    self.formattedTime = formattedTimer.formattedTime;
                                }

                            } else {
                                if isTimerRunning == true {
                                    stopTimer();
                                }
                                isClockOverSheetPresented = true;
                                self.formattedTime = "00:00:00:00"
                            }
                        }
                        .id(clockListId)
                }

            }
            
            else {
                
                ZStack{
                    Text("\(clocks.isEmpty ? "No timer has been created" : "No timer has been selected")")
                        .font(Font.custom("Digital-7", size: 155))
                        .foregroundStyle(Color("Red"))
                        .multilineTextAlignment(.center)
                        .blur(radius: 8.0)
                    Text("\(clocks.isEmpty ? "No timer has been created" : "No timer has been selected")")
                        .font(Font.custom("Digital-7", size: 155))
                        .foregroundStyle(Color("LightRed"))
                        .multilineTextAlignment(.center)
                        .onChange(of: currentClockId){
                            if let currentClock = self.currentClock {
                                formattedTimer = ClockToTextConverter(clock: currentClock);
                            }
                        }
                }

            }
        }
        .onAppear{
            if let currentClock = self.currentClock {
                self.isClockOverSheetPresented = currentClock.remainingTime > 0 ? true : false;
            }
        }
        //Move this to ClockListManager
        .sheet(isPresented: self.$isClockOverSheetPresented, content: {
            if let currentClock = self.currentClock {
                ClockOverSheet(isClockRecapitulationPresented: self.$isClockOverSheetPresented, clock: currentClock, addClock: self.addClock, deleteClock: self.deleteClock, editClock: self.editClock)
            }
            

        })
        .padding()
    }
    
    
    func stopTimer(){
        self.isTimerRunning = false;
        self.timer.upstream.connect().cancel();
    }
    
    func startTimer(){
        self.isTimerRunning = true;
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect();
    }
    
}



