//
//  ContentView.swift
//  Advent2021
//
//  Created by Thompson,Matthew on 12/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Day One", destination: Day1View())
            }.navigationTitle("Advent of code 2021")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
