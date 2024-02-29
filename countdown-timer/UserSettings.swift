//
//  UserSettings.swift
//  todo-list
//
//  Created by Yohance Williams on 1/31/24.
//

import Foundation

class UserSettings: ObservableObject{
    
    @Published var isSideBarPrefered: Bool = true;

    var idealHeight: CGFloat {get {return self.screenSizeHeight * HEIGHT_RATIO_CONSTANT}};
    private var screenSizeHeight: CGFloat;
    var screenSizeWidth: CGFloat;
    
    var HEIGHT_RATIO_CONSTANT: CGFloat = 0.457143;
    var WIDTH_RATIO_CONSTANT: CGFloat = 0.90;
    
    enum UserSettingsError: Error{
        case invalidScreenSize;
    }
    
    init(screenSizeWidth: CGFloat, screenSizeHeight: CGFloat){
        self.screenSizeWidth = screenSizeWidth;
        self.screenSizeHeight = screenSizeHeight;
    }
    
}
