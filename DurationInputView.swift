//
//  DurationInputView.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/24/24.
//

import Foundation
import SwiftUI

struct DurationInputView: View {
    
    
    @Binding var clockDays: String;
    @Binding var clockHours: String;
    @Binding var clockMinutes: String;
    @Binding var clockSeconds: String;
    
    var body: some View {
        HStack{
            VStack{
                
                TextField("D", text: $clockDays)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)
                    .onChange(of: clockDays) {
                        
                        var filtered = clockDays;
                        filtered = filtered.filter{ "0123456789".contains($0)}
                         if filtered != String(clockDays) {
                             self.clockDays = filtered
                         }
                     }
                Text("Days")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            VStack {
                  Text(":")
                      .font(.title)
                      .padding(.vertical, 30)
              }
              
              VStack {
                  TextField("H", text: $clockHours)
                      .textFieldStyle(PlainTextFieldStyle())
                      .padding()
                      .multilineTextAlignment(.center)
                      .onChange(of: clockHours) {
                          
                          var filtered = clockHours;
                          filtered = filtered.filter{ "0123456789".contains($0)}
                           if filtered != String(clockHours) {
                               self.clockHours = filtered
                           }
                       }

                  Text("Hours")
                      .font(.caption)
                      .foregroundColor(.gray)
              }
              
              VStack {
                  Text(":")
                      .font(.title)
                      .padding(.vertical, 30)
              }
              
              VStack {
                  TextField("M", text: $clockMinutes)
                      .textFieldStyle(PlainTextFieldStyle())
                      .padding()
                      .multilineTextAlignment(.center)
                      .onChange(of: clockMinutes) {
                          
                          var filtered = clockMinutes;
                          filtered = filtered.filter{ "0123456789".contains($0)}
                           if filtered != String(clockMinutes) {
                               self.clockMinutes = filtered
                           }
                       }
                  
                  Text("Minutes")
                      .font(.caption)
                      .foregroundColor(.gray)
              }
              
              VStack {
                  Text(":")
                      .font(.title)
                      .padding(.vertical, 30)
              }
              
              VStack {
                  TextField("S", text: $clockSeconds)
                      .textFieldStyle(PlainTextFieldStyle())
                      .padding()
                      .multilineTextAlignment(.center)
                      .onChange(of: clockSeconds) {
                          
                          var filtered = clockSeconds;
                          filtered = filtered.filter{ "0123456789".contains($0)}
                           if filtered != String(clockSeconds) {
                               self.clockSeconds = filtered
                           }
                       }
                  
                  Text("Seconds")
                      .font(.caption)
                      .foregroundColor(.gray)
              }

        }
    }
    
}
