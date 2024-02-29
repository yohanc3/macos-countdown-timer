//
//  ClocksList.swift
//  todo-list
//
//  Created by Yohance Williams on 2/1/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ClocksList: View {
    
    @Query var clocks: [Clock];
    @Binding var clockListId: UUID;
    @Binding var currentClock: Clock?;
    
    var selectClock: (Clock) -> Void;
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 0) {
                ForEach(clocks, id: \.id) { clock in
                    if let currentClock = self.currentClock, clock.id == currentClock.id {
                        Button{
                            
                        } label: {
                            Text("\(clock.name)")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                        }
                        .buttonStyle(.borderless)
                        
                    } else {
                        Button{
                            selectClock(clock);
                        } label: {
                            Text(clock.name)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                        }
                        //bordeless style somehow allows clicks for the
                        //entirety of the button and the style looks like .plain
                        .buttonStyle(.borderless)
                    }
                    
                    Divider()
                }
            }
            .padding(.top, 5)
        }.id(clockListId)
    }
}
