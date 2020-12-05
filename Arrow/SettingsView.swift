//
//  OptionsView.swift
//  Arrow
//
//  Created by David Williams on 11/28/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

struct CompactThemePreview: View {
    @Binding var theme: ArrowTheme
    
    var body: some View {
        HStack {
            Circle()
                .fill(theme.offColor)
                .frame(width: 20, height: 20)
                .padding(5)
            Circle()
                .fill(theme.onColor)
                .frame(width: 20, height: 20)
                .padding(5)
        }
        .padding(5)
        .background(theme.backgroundColor)
    }
}

@available(iOS 14, *)
struct ThemeEditor: View {
    @Binding var showEditor: Bool
    @ObservedObject var settings: ArrowSettings
    @State var backgroundColor: Color = DefaultThemes.choices[0].backgroundColor
    @State var onColor: Color         = DefaultThemes.choices[0].onColor
    @State var offColor: Color        = DefaultThemes.choices[0].offColor
    @State var controlColor: Color    = DefaultThemes.choices[0].controlColor

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Preview")) {
                        HStack {
                            Circle()
                                .fill(offColor)
                                .frame(width: 20, height: 20)
                                .padding(5)
                            Circle()
                                .fill(offColor)
                                .frame(width: 20, height: 20)
                                .padding(5)
                            Circle()
                                .fill(onColor)
                                .frame(width: 20, height: 20)
                                .padding(5)
                            Circle()
                                .fill(onColor)
                                .frame(width: 20, height: 20)
                                .padding(5)
                            Image( systemName: "slider.vertical.3" )
                                .imageScale(.large)
                                .foregroundColor(controlColor)
                        }
                        .padding(15)
                        .background(backgroundColor)
                    }
                    Section(header: Text("Color Selection")) {
                        ColorPicker("Background", selection: self.$backgroundColor)
                        ColorPicker("Bulb On",    selection: self.$onColor)
                        ColorPicker("Bulb Off",   selection: self.$offColor)
                        ColorPicker("Control",    selection: self.$controlColor)
                    }
                }
                .navigationTitle("New Theme")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button(action: {
                        self.showEditor = false
                    }) {
                        Text("Cancel")
                    },
                    trailing: Button(action: {
                        // We might as well assume the user wants to use the new theme
                        self.settings.theme = self.settings.themes.count
                        self.settings.themes.append(ArrowTheme(
                            backgroundColor: backgroundColor,
                            onColor: onColor,
                            offColor: offColor,
                            controlColor: controlColor
                        ))
                        self.showEditor = false
                    }) {
                        Text("Add")
                    }
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomThemeListView: View {
    @Binding var showThemes: Bool
    @ObservedObject var settings: ArrowSettings
    @State var showThemeEditor: Bool = false

    var body: some View {
        NavigationView {
            Form {
                ForEach(settings.numberThemesFixed..<settings.themes.count, id: \.self) { it in
                    HStack {
                        CompactThemePreview(theme: $settings.themes[it])
                            .accessibility(label: Text("Theme number \(it)"))
                        Spacer()
                        Button( action: {
                            settings.RemoveTheme(at: it)
                        }) {
                            Image( systemName: "trash" )
                                .imageScale(.large)
                                .accessibility(label: Text("Trash theme number \(it)"))
                        }
                    }
                }
                
                if #available(iOS 14, *) {
                    // Sorry, we need iOS 14 for the color picker
                    Button(action: {self.showThemeEditor.toggle()}) {
                        Text(verbatim: "Add Theme…")
                    }
                    .sheet(isPresented: self.$showThemeEditor) {
                        ThemeEditor(
                            showEditor: self.$showThemeEditor,
                            settings: settings
                        )
                    }
                }
            }
            .navigationTitle("Custom Themes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.showThemes = false
                }) {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.left")
                        Text("Settings")
                    }
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView: View {
    @Binding var showingSettings: Bool
    @ObservedObject var settings: ArrowSettings
    @State var showThemeList: Bool = false

    //
    // These is a fixed ArrowBoard theme created to appear
    // reasonable in a form
    //
    let settingsTheme = ArrowTheme(
        backgroundColor: Color(UIColor.secondaryLabel),
        onColor: Color(UIColor.systemBackground),
        offColor: Color(UIColor.secondaryLabel),
        controlColor: Color.black
    )
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Animation")) {
                    let clock = ArrowClock(every: settings.interval)
                    
                    Picker(selection: $settings.pattern, label: Text("Board")) {
                        ForEach(0..<settings.patterns.count, id: \.self) { ip in
                            ArrowBoardView(
                                geometry: settings.geometry,
                                theme: settingsTheme,
                                frame: clock,
                                pattern: settings.patterns[ip]
                            )
                            .frame(width: 100, height: 50)
                            .background(settingsTheme.backgroundColor)
                            .accessibility(label: Text("Board number \(ip)"))
                        }
                    }
                        
                    HStack {
                        Text("Interval")
                        Slider(value: $settings.interval, in: 0.1...2)
                            .accessibility(label: Text("Animation interval"))
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Picker(selection: $settings.theme, label: Text("Theme")) {
                        ForEach(0..<settings.themes.count, id: \.self) { it in
                            CompactThemePreview(theme: $settings.themes[it])
                                .accessibility(label: Text("Theme number \(it)"))
                        }
                    }

                    Button(action: {self.showThemeList.toggle()}) {
                        Text(verbatim: "Customize…")
                    }
                    .sheet(isPresented: self.$showThemeList) {
                        CustomThemeListView(
                            showThemes: self.$showThemeList,
                            settings: settings
                        )
                    }
                }
                
                Section(header: Text("About")) {
                    let appVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                    }

                    Text("Copyright © 2020 David C. Williams")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .font(.footnote)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                self.showingSettings = false
            }) {
                Text("Done")
            })
        }
    }
}
