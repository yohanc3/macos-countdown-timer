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
    @State var clock: Clock;
    var addClock: (String, Int) -> Void;
    var deleteClock: (Clock) -> Void;
    var editClock: (String, Int) -> Void;
    
    @State var currentClockName: String = "";
    @State var isDeleteSheetPresented: Bool = false;
    @State var isEditSheetPresented: Bool = false;
    @State var isEdit: Bool = true;
    
    var body: some View {
        
        VStack{
            Spacer();
            HStack{
                Text("Timer finished")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            Spacer();
            HStack{
                Text("Timer finished on \(clock.objectiveDate.formatted(.dateTime.day().month().year().hour().minute().second()))")
            }
            Spacer();
            HStack{
                Spacer();
                Button("Exit"){
                    isClockRecapitulationPresented = false;
                }
                Spacer();
                Button("Edit"){
                    self.isEditSheetPresented = true;
                }
                .sheet(isPresented: self.$isEditSheetPresented, content: {
                    ClockEditAddView(clock: clock, currentClockName: self.$currentClockName, isSheetPresented: self.$isEditSheetPresented, isEdit: self.$isEdit, editAddClock: self.editClock, isClockOverSheetPresented: self.$isClockRecapitulationPresented)
                })
                Spacer();
                Button("Delete"){
                    self.isDeleteSheetPresented = true;
                }.sheet(isPresented: self.$isDeleteSheetPresented, content: {
                    ClockDeleteView(currentClock: self.clock, currentClockName: self.$currentClockName, isDeleteSheetPresented: self.$isDeleteSheetPresented, isClockOverSheetPresented: self.$isClockRecapitulationPresented, deleteClock: self.deleteClock)
                })
                Spacer();
            }
            
            Spacer();
        }
        .frame(width: 500, height: 300)
        .onAppear{
            currentClockName = self.clock.name;
            
        }
        
    }
}
    
