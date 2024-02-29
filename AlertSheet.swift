//
//  AlertSheet.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/28/24.
//

import SwiftUI

struct AlertSheet: View {
    
    @Binding var isSheetPresented: Bool;
    @Binding var alertTitle: String;
    
    var body: some View {
        
        VStack{
            
            Spacer();
            
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 40)
            
            Spacer();
            
            Text(alertTitle)

            Spacer();
            
            Button(action: {
                isSheetPresented = false;

            }){
                Text("OK")
                    .frame(width: 150)
            }
            
            Spacer();
            
        }
        .frame(width: 300, height: 200)
        .padding()
        

    }

}
