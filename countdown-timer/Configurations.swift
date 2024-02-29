//
//  Configurations.swift
//  todo-list
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation
import SwiftUI

struct Configurations: View{
    
    @State private var someText: String = "";
    
    var body: some View {
        VStack(spacing: 20){
            Text("Coming soon.")
                .multilineTextAlignment(.center)
        }
        .padding();
    }
}
