//
//  UploadDetailView.swift
//  Associate
//
//  Created by 90302939 on 5/19/20.
//  Copyright © 2020 Eden Prairie Schools. All rights reserved.
//

import SwiftUI

struct UploadDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var profile: Profile
    
    @State private var identifier: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var whichChapter: Int = 0
    @State private var datesInvalid: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Select a chapter to put this page in:"), footer: Text("Currently selected: \(profile.book.chapters[whichChapter].identifier)")) {
                Picker(selection: $whichChapter, label: Text("Choose a Chapter:")) {
                    ForEach(0 ..< self.profile.book.chapters.count, id: \.self) {
                        Text(self.profile.book.chapters[$0].identifier)
                    }
                }
                .labelsHidden()
            }
            
            Section(header: Text("Name of Event (Required)"), content: {
                TextField("Enter name", text: $identifier)
            })
            Section(header: Text("Description"), content: {
                TextField("Enter description", text: $description)
                    .multilineTextAlignment(.leading)
            })
            Section(header: Text("Add an Image"), content: {
                NavigationLink(destination: UploadImageView()) {
                    Text("Add an Image")
                }
            })
            Section(header: Text("Starting and Ending Dates"), content: {
                DatePicker("Start", selection: $startDate)
                    .labelsHidden()
                DatePicker("End", selection: $endDate)
                    .labelsHidden()
            })
            
            // Save button
            Button(action: {
                self.datesAreInvalid()
                
                if !self.datesInvalid {
                    self.profile.book.chapters[self.whichChapter].addPage(page: Page(identifier: self.identifier, description: self.description, startDate: self.startDate, endDate: self.endDate))
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.offGray[0], Color.offGray[11]]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 150, height: 60)
                        .clipShape(Capsule())
                    Text("Save")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 10)
            .centerInForm()
        }
        .navigationBarTitle("Upload", displayMode: .inline)
        .alert(isPresented: $datesInvalid) {
            return Alert(title: Text("Error"), message: Text("Please ensure the specified start date occurs before the specified end date."), dismissButton: .default(Text("Okay")))
        }
    }
    
    func datesAreInvalid() {
        if case .orderedDescending = startDate.compare(endDate) {
            datesInvalid = true
        } else {
            datesInvalid = false
        }
    }
}

struct UploadDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UploadDetailView()
    }
}
