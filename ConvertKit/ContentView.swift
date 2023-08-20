//
//  ContentView.swift
//  ConvertKit
//
//  Created by Miten Gajjar on 20/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            Text("Select an option from below")
            NavigationLink("Temperature"){
                TemperatureView()
            }
            NavigationLink("Length"){
                LengthView()
            }
            NavigationLink("Time"){
                TimeView()
            }
            NavigationLink("Volume"){
                VolumeView()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
