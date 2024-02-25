//
//  DatePicker.swift
//  countdown-timer
//
//  Created by Yohance Williams on 2/25/24.
//

import Foundation
import SwiftUI

struct MyDatePicker: NSViewRepresentable {
    @Binding var selection: Date

    func makeNSView(context: Context) -> NSDatePicker {
        let picker = NSDatePicker()
        picker.isBordered = false;
        picker.presentsCalendarOverlay = true;
        picker.datePickerStyle = .textFieldAndStepper
        picker.action = #selector(Coordinator.onValueChange(_:))
        picker.target = context.coordinator
        return picker
    }

    func updateNSView(_ picker: NSDatePicker, context: Context) {
        picker.dateValue = selection
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }

    class Coordinator: NSObject {
        private let owner: MyDatePicker
        init(owner: MyDatePicker) {
            self.owner = owner
        }

        @objc func onValueChange(_ sender: Any?) {
            if let picker = sender as? NSDatePicker {
                owner.selection = picker.dateValue
            }
        }
    }
}
