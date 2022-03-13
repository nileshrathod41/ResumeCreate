//
//  ContactsTabView.swift
//  AnyMindResume
//
//  Created by Nil Rathod on 11/03/22.
//

import SwiftUI

/// Contacts view
struct ContactsTabView: View {
    
    @ObservedObject var manager: PDFManager
    @State private var bottomPadding: CGFloat = 30
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            Spacer(minLength: 20)
            VStack(alignment: .leading, spacing: 30) {
                Text("Phone, Email and Website?")
                    .font(.system(size: 22)).bold()
                Text("How would you like a potential employer to contact you?")
                VStack(spacing: 35) {
                    CustomTextField(text: $manager.userInfo.email, placeholderText: "example@gmail.com")
                        .keyboardType(.emailAddress).disableAutocorrection(true).textCase(.lowercase)
                    CustomTextField(text: $manager.userInfo.phone, formatter: .phone, placeholderText: "(555) 456-7890")
                        .keyboardType(.numberPad)
                    CustomTextField(text: $manager.userInfo.website, formatter: .website, placeholderText: "www.example.com")
                        .disableAutocorrection(true).textCase(.lowercase)
                    CustomTextField(text: $manager.userInfo.address, placeholderText: "123 Main Street, Bangkok")
                }
                Text("Providing full contact info (email address, phone, LinkedIn, etc.) is a huge factor for your interview chances!")
                    .opacity(0.4).padding(.top, 20)
                Spacer(minLength: bottomPadding)
            }.padding(30)
            Spacer(minLength: 100)
        })
        .onAppear(perform: {
            NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillShowNotification, object: nil, queue: nil) { _ in
                bottomPadding = 250
            }
            NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillHideNotification, object: nil, queue: nil) { _ in
                bottomPadding = 30
            }
        })
    }
}

// MARK: - Preview UI
struct ContactsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsTabView(manager: PDFManager())
    }
}
