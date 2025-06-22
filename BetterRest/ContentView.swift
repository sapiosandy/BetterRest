//
//  ContentView.swift
//  BetterRest
//
//  Created by Sandra Gomez on 6/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    func exampleDates() {
//        var components = DateComponents()
//        componenets.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
        
        var components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

#Preview {
    ContentView()
}
