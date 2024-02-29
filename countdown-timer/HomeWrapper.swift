//
//  HomeWrapper.swift
//  todo-list
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation
import SwiftUI
import SwiftData

struct HomeWrapper: View {
    
    @Environment(\.modelContext) var clocksContext
    @EnvironmentObject private var settings: UserSettings;
    
    @Binding var currentClockName: String;
    @State var currentClock: Clock? = nil;
    @Binding var currentClockId: String;
    @Binding var clockListId: UUID;
    
    @Query var clocks: [Clock];
    
    @State var isAlertPresent: Bool = false;
    @State var alertTitle: String = "";
    
    var body: some View {
        HStack(spacing: 0){
            Home(currentClock: self.$currentClock, currentClockId: self.$currentClockId, clockListId: self.$clockListId)
                .frame(width: (settings.screenSizeWidth * 0.90), height: settings.idealHeight)
                .onAppear{
                    currentClock = clocks.first(where: {$0.isCurrentClock == true})
                }

            
            Divider()
                .overlay(Color("Divider"))
            
            Sidebar(currentClockName: $currentClockName, currentClock: self.$currentClock, clockListId: self.$clockListId, selectClock: self.selectClock, deleteClock: self.deleteClock, addClock: self.addClock, editClock: self.editClock)
                .onChange(of: currentClockId){
                    if let currentClock = self.currentClock {
                        currentClockName = currentClock.name
                    } else {
                        currentClockName = "";
                    }
                }
                .frame(width: (settings.screenSizeWidth * 0.10), height: settings.idealHeight)
        }
        .sheet(isPresented: self.$isAlertPresent, content: {
            AlertSheet(isSheetPresented: self.$isAlertPresent, alertTitle: self.$alertTitle)
        })
    }

    func addClock(name: String, remainingTime: Int){
        
        let newClock = Clock(name: name, durationInSeconds: remainingTime)
        clocksContext.insert(newClock);
        
        do {
            try clocksContext.save();
        } catch{
            alertTitle = "Error at saving changes."
            isAlertPresent = true;
        }
                
        if clocks.count == 1 {
            selectClock(clock: clocks[0])
        }
        
        self.clockListId = UUID()
    }
    
    func deleteClock(clockToDelete: Clock){
        
        var nextClockIndex = -1;
        
           if let index = clocks.firstIndex(of: clockToDelete) {
               
               if let clock = clocks.indices.contains(index - 1) ? clocks[index - 1] : nil {
                   nextClockIndex = index - 1;
               } else if let clock = clocks.indices.contains(index + 1) ? clocks[index + 1] : nil {
                   nextClockIndex = index + 1;
               }
               
               if nextClockIndex >= 0 {
                   currentClock = clocks[nextClockIndex];
                   if let currentClock = currentClock {
                       currentClockId = currentClock.id;
                   }
               } else {
                   currentClock = nil;
                   currentClockId = "";
               }
               
               clocksContext.delete(clocks[index])
               
               do {
                   try clocksContext.save();
               } catch {
                   alertTitle = "Error at saving changes."
                   isAlertPresent = true;
               }
               
           } else {
               alertTitle = "Error at deleting clock."
               isAlertPresent = true;
           }
    
        self.clockListId = UUID();
    }
    
    func editClock(newName: String, newRemainingTime: Int){
        
        if let currentClock = self.currentClock{
            
            currentClock.editClock(name: newName, newRemainingTime: newRemainingTime)
            currentClockName = newName;
            self.clockListId = UUID();
            
        }
        
        do {
            try clocksContext.save()
        } catch {
            alertTitle = "Error at saving changes."
            isAlertPresent = true;
        }
        
    }
    
    func selectClock(clock: Clock){

        let clockId = clock.id;
        
        if let currentClock = clocks.first(where: {$0.id == clockId}) {
            
            self.currentClock = currentClock;
            self.currentClockId = clockId;
            
            for clock in clocks {
                if clock != currentClock {
                    clock.isCurrentClock = false;
                } else {
                    clock.isCurrentClock = true
                }
            }
            
            do {
                try clocksContext.save()
            } catch {
                alertTitle = "Error at saving changes."
                isAlertPresent = true;
            }
            
        }
        else {
            alertTitle = "Error at selecting clock."
            isAlertPresent = true;
        }
    }
    
}


protocol TimeConverter {
    var remainingTime: Double { get set }
    var formattedTime: String { get }
    
    func setFormattedTime()
    func handleDaysDecrease()
    func handleHoursDecrease()
    func handleMinutesDecrease()
    func handleSecondsDecrease()
    func refreshRemainingTime()
    func parseNumber(value: Int) -> String
}
