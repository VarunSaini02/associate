//
//  ProfileView.swift
//  Associate
//
//  Created by 90302939 on 4/28/20.
//  Copyright © 2020 Eden Prairie Schools. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profile: Profile
    @State private var whichChapter = 0
    
    var body: some View {
        VStack {
            profile.profilePic
                .resizable()
                .scaledToFit()
                .cornerRadius(45)
                .padding(.bottom)
            Text(profile.name.fullName)
            
            NavigationLink(destination: ProfileDetailView()) {
                Text("View Profile")
            }.padding()
            
            Picker(selection: $whichChapter, label: Text("Choose a Chapter:")) {
                ForEach(0 ..< profile.book.chapters.count) {
                    Text(self.profile.book.chapters[$0].identifier)
                }
            }.pickerStyle(WheelPickerStyle()).labelsHidden()
            
            List {
                ForEach(profile.book.chapters[whichChapter].pages) { page in
                    NavigationLink(destination: PastEventsView(page: page)) {
                        Text(page.identifier)
                    }
                }
                .onDelete { (indexSet) in
                    self.profile.book.chapters[self.whichChapter].pages.remove(atOffsets: indexSet)
                    self.profile.book.chapters[self.whichChapter].sortPagesAlphabetically()
                    self.profile.book.chapters[self.whichChapter].setUpAnyCancellable()
                }
            }
        }
        .padding(.top, 20)
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

