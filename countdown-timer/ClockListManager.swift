//
//  ClockListManager.swift
//  todo-list
//
//  Created by Yohance Williams on 2/1/24.
//

import Foundation
import SwiftUI

struct ClockListManager: View {
    
    @State private var isDeleteSheetPresented: Bool = false;
    @State private var isAddSheetPresented: Bool = false;
    @State private var isEditSheetPresented: Bool = false;
    
    @State private var fakeClock: Clock = Clock(name: "", durationInSeconds: 0)
    
    @Binding var currentClockName: String;
    @Binding var currentClock: Clock?;
    
    var addClock: (String, Int) -> Void;
    var deleteClock: (Clock) -> Void;
    var editClock: (String, Int) -> Void;
    
    @State var isAlertPresented: Bool = false;
    @State var alertTitle: String = "";
    
    var body: some View {
        GeometryReader {geometry in
            HStack(spacing: 0){
                Button(action:{
                    if self.currentClock != nil {
                        isEditSheetPresented = true;
                    } else {
                        alertTitle = "To edit a clock, select it first."
                        isAlertPresented = true;
                    }
                }){
                    Image(systemName: "pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 20)
                        .foregroundColor(.blue)
                        .opacity( currentClock == nil ? 0.5 : 1.0);
                }
                .frame(width: geometry.size.width / 3)
                .sheet(isPresented: self.$isEditSheetPresented){
                    if let currentClock = self.currentClock {
                        ClockEditAddView(clock: currentClock, currentClockName: self.$currentClockName, isSheetPresented: self.$isEditSheetPresented, isEdit: $isEditSheetPresented, editAddClock: self.editClock)
                    }
                }
                
                Divider()
                
                Button(action: {
                    isAddSheetPresented = true;
                }){
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 20)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .frame(width: geometry.size.width / 3)
                .sheet(isPresented: self.$isAddSheetPresented){
                    if isEditSheetPresented == false {
                        ClockEditAddView(clock: fakeClock, currentClockName: self.$currentClockName, isSheetPresented: self.$isAddSheetPresented, isEdit: $isEditSheetPresented, editAddClock: self.addClock)
                    }
                }
                    
                    Divider()
                    
                    Button(action: {
                        if self.currentClock != nil {
                            isDeleteSheetPresented = true;
                        } else {
                            alertTitle = "To delete a clock, select it first."
                            isAlertPresented = true;
                        }
                        
                    }){
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 20)
                            .foregroundColor(.blue)
                            .opacity( currentClock == nil ? 0.5 : 1.0);
                    }
                    .frame(width: geometry.size.width / 3)
                    .sheet(isPresented: self.$isDeleteSheetPresented){
                        if self.currentClock != nil {
                            ClockDeleteView(currentClock: self.$currentClock, currentClockName: self.$currentClockName, isDeleteSheetPresented: self.$isDeleteSheetPresented, deleteClock: self.deleteClock)
                        }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity)
        }
        .sheet(isPresented: $isAlertPresented){
            AlertSheet(isSheetPresented: self.$isAlertPresented, alertTitle: self.$alertTitle)
        }
    }
}
