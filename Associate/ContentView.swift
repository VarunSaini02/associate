//
//  ContentView.swift
//  Associate
//
//  Created by Varun Saini, Bela Konkoly, and Blake Branvold on 4/28/20.
//  Copyright © 2020 Eden Prairie Schools. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            OppsView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe") //get noun project from nelson
                        Text("Opportunities")
                    }
            }
            .tag(1)
            
            UploadView()
                .tabItem {
                    VStack {
                        Image(systemName: "arrow.up.square.fill") //get noun project from nelson
                        Text("Upload")
                    }
            }
            .tag(0)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill") //get noun project from nelson
                        Text("Profile")
                    }
            }
            .tag(2)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

