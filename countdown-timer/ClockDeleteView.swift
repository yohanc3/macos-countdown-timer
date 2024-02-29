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
        
        VStack{
            
            HStack(){
                Text("Delete clock: \(currentClockName)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 25, trailing: 0))
            
            VStack {
                
                TextField("del", text: $deleteConfirmation)
                .padding()
                .foregroundStyle(deleteConfirmationBool ? Color.blue : Color.red)
                .multilineTextAlignment(.center)
                .onChange(of: deleteConfirmation){
                    if deleteConfirmation == "del" {deleteConfirmationBool = true}
                    else {deleteConfirmationBool = false};
                }
                
                Text("Type ").font(.footnote) +
                Text("del ").bold().italic().font(.footnote) +
                Text("to ").font(.footnote) +
                Text("permanently delete ").bold().italic().font(.footnote) +
                Text("this clock ").font(.footnote)
                
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))


            
            HStack(spacing: 20){
                Button("Delete"){
                    if let clock = currentClock, deleteConfirmationBool {
                        deleteClock(clock)
                        isDeleteSheetPresented = false;
                    }
                }
                .padding()
                
                Spacer()
                
                Button("Exit"){
                    isDeleteSheetPresented = false;
                }
                .padding()
            }

        
            
        }
        .frame(width: 500, height: 300)
        .padding(EdgeInsets(top: 0, leading: 100, bottom: 50, trailing: 100))
        
    }
    
}
