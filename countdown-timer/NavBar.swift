//
//  NavBar.swift
//  todo-list
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation
import SwiftUI

struct NavBar: View {
    
    @Binding var isConfigOn: Bool;
    
    var body: some View {
        HStack(){
        }.toolbar{
            ToolbarItemGroup{
                Button("Home"){
                    setConfig(val: false)
                }
                Button("Configurations"){
                    setConfig(val: true)
                }
            }
        }
    }
    
    private func setConfig(val: Bool){
       self.isConfigOn = val;
   }
    
}
