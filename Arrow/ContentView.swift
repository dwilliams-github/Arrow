//
//  ContentView.swift
//  Arrow
//
//  Created by David Williams on 11/14/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var settings = ArrowSettings();
    @State var showingSettings: Bool = false
    
    var body: some View {
        ZStack {
            settings.Theme().backgroundColor.ignoresSafeArea()
            
            AnimatedArrowBoardView(settings: settings)
                .aspectRatio(CGSize(width:2,height:1), contentMode: .fit)

            Button(action: {showingSettings.toggle()}) {
                Image(systemName: "slider.vertical.3")
                    .imageScale(.large)
                    .accessibility(label: Text("Settings"))
                    .foregroundColor(settings.Theme().controlColor)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
            .padding(10)
            .sheet(isPresented: $showingSettings) {
                SettingsView(showingSettings: $showingSettings, settings: settings)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
