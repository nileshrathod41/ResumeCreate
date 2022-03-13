//
//  AboutTabView.swift
//  AnyMindResume
//
//  Created by Nil Rathod on 11/03/22.
//

import SwiftUI

////  About tab
struct AboutTabView: View {
    
    @ObservedObject var manager: PDFManager
    @State private var isShowPhotoLibrary = false
    @State private var isPlaceholderShown = true
    
    @State private var image = UIImage()
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            Spacer(minLength: 20)
            VStack(alignment: .leading, spacing: 30) {
                Text("Let's get started with your Information.")
                    .font(.system(size: 22)).bold()
                HStack() {
                    let newImage = UIImage(named: "iconsPerson")
                    Image(uiImage: isPlaceholderShown ? newImage! : self.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .clipShape(Circle())
                    
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                                
                            Text("Photo")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
                        if self.image.size.width != 0 {
                            self.isPlaceholderShown = false
                        }
                            }, content: {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            })
                }
                Text("What is your name?")
                VStack(spacing: 35) {
                    CustomTextField(text: $manager.userInfo.firstName, placeholderText: "First Name")
                    CustomTextField(text: $manager.userInfo.lastName, placeholderText: "Last Name")
                }
            }.padding(30)
            Spacer(minLength: 100)
        })
    }
}

// MARK: - Preview UI  
struct AboutTabView_Previews: PreviewProvider {
    static var previews: some View {
        AboutTabView(manager: PDFManager())
    }
}
