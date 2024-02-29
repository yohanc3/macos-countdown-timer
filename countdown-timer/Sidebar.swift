//
//  Sidebar.swift
//  todo-list
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation
import SwiftUI
import SwiftData

struct Sidebar: View {
    
    @EnvironmentObject private var settings: UserSettings;
        
    @Query var clocks: [Clock];
    @Binding var currentClockName: String;
    @Binding var currentClock: Clock?;
    @Binding var clockListId: UUID;

    var selectClock: (Clock) -> Void;
    var deleteClock: (Clock) -> Void;
    var addClock: (String, Int) -> Void;
    var editClock: (String, Int) -> Void;
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 0
        ){
            ClocksList(clockListId: self.$clockListId, currentClock: self.$currentClock, selectClock: self.selectClock)
                .frame(height: (settings.idealHeight * 0.90))
            
            Divider()
            
            ClockListManager(currentClockName: self.$currentClockName, currentClock: self.$currentClock, addClock: self.addClock, deleteClock: self.deleteClock, editClock: self.editClock)
                .frame(height: (settings.idealHeight * 0.125))
        }
        
    }
}


