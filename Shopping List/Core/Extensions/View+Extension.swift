//
//  View+Extension.swift
//  Shopping List
//
//  Created by Motasem Asfoor on 10/02/2026.
//

import Foundation
import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
