//
//  todo_listApp.swift
//  todo-list
//
//  Created by Yohance Williams on 1/30/24.
//

//Todo: Add info sheet for clocks that are over

import SwiftUI
import SwiftData
import AppKit

@main
struct todo_listApp: App{
    
    @StateObject var settings = UserSettings(screenSizeWidth: NSScreen.main?.visibleFrame.size.width ?? 1440, screenSizeHeight: NSScreen.main?.visibleFrame.size.height ?? 875)
    
    @State private var isConfigOn: Bool = false;
    
    @State private var currentClock: Clock? = nil;
    @State private var currentClockId: String = "";
    @State var currentClockName: String = "";
    @State var clockListId: UUID = UUID();
    
    var body: some Scene {
        WindowGroup {
            NavBar(isConfigOn: $isConfigOn)
            
            switch isConfigOn {
            case true:
                Configurations()
                    .frame(width: settings.screenSizeWidth, height: (settings.idealHeight))
                    .background(Color("Background"))
                    .environmentObject(settings)
                
            case false:
                HomeWrapper(
                    currentClockName: self.$currentClockName,
                    currentClock: self.currentClock,
                    currentClockId: self.$currentClockId,
                    clockListId: self.$clockListId
                )
                .frame(width: settings.screenSizeWidth, height: settings.idealHeight)
                .background(Color("Background"))
                .environmentObject(settings)

            }

        }
        .windowResizability(.contentSize)
        .modelContainer(for: [Clock.self])

    }
    
}
