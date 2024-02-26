//
//  ClockDeleteView.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/6/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ClockDeleteView: View {
    
    @Environment(\.modelContext) var context
    
    @State var deleteConfirmation: String = "";
    @State var deleteConfirmationBool: Bool = false;
    
    @Binding var currentClock: Clock?;
    @Binding var currentClockName: String;
    @Binding var isDeleteSheetPresented: Bool;
    
    @Query var clocks: [Clock]
    
    var deleteClock: (Clock) -> Void;
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            Text(currentClockName).font(.headline)
            
            Text("Type ") +
            Text("del ").bold().italic() +
            Text("to ") +
            Text("permanently delete ").bold().italic() +
            Text("this clock ")

            TextField("del",
                      text: $deleteConfirmation)
            .padding()
            .foregroundStyle(deleteConfirmationBool ? Color.blue : Color.red)
            .multilineTextAlignment(.center)
            .onChange(of: deleteConfirmation){
                if deleteConfirmation == "del" {deleteConfirmationBool = true}
                else {deleteConfirmationBool = false};
            }
            
            HStack(spacing: 20){
                Button("Delete"){
                    if let clock = currentClock, deleteConfirmationBool {
                        deleteClock(clock)
                        isDeleteSheetPresented = false;
                    }
                }
                .padding()
                Button("Exit"){
                    isDeleteSheetPresented = false;
                }
                .padding()
            }

        
            
        }
        .padding(20)
        
    }
    
}
