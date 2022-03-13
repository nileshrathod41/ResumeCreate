//
//  AnyMindResumeApp.swift
//  AnyMindResume
//
//  Created by Nil Rathod on 11/03/22.
//

import SwiftUI

@main
struct ResumeBuilderApp: App {
    
    // MARK: - Main rendering function
    var body: some Scene {
        return WindowGroup {
                DashboardContentView()
            }
        }
    }

// MARK: - Useful extensions
extension String {
    var formattedWebsite: String {
        if lowercased().contains("http") || contains("https") {
            return self
        }
        return self.count > 3 ? "https://\(self.replacingOccurrences(of: " ", with: ""))" : ""
    }
    
    var formattedPhoneNumber: String {
        return replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
