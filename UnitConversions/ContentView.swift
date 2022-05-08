//
//  ContentView.swift
//  UnitConversions
//
//  Created by Павел Кай on 08.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var userNumber = 0.0
    @State private var selectedUnitYour = "mm"
    @State private var selectedUnitConvert = "mm"
    @State private var outputUnit = 0.0
    
    @FocusState private var enterFocus: Bool
    
    let units = ["mm", "cm", "dm", "m", "km"]
    
    var user: Measurement<UnitLength> {
        switch selectedUnitYour {
        case "mm":
            return Measurement(value: userNumber, unit: UnitLength.millimeters)
        case "cm":
            return Measurement(value: userNumber, unit: UnitLength.centimeters)
        case "dm":
            return Measurement(value: userNumber, unit: UnitLength.decimeters)
        case "m":
            return Measurement(value: userNumber, unit: UnitLength.meters)
        case "km":
            return Measurement(value: userNumber, unit: UnitLength.kilometers)
        default:
            return Measurement(value: userNumber, unit: UnitLength.millimeters)
        }
    }
    
    var converting: Measurement<UnitLength> {
        switch selectedUnitConvert {
        case "mm":
            return user.converted(to: UnitLength.millimeters)
        case "cm":
            return user.converted(to: UnitLength.centimeters)
        case "dm":
            return user.converted(to: UnitLength.decimeters)
        case "m":
            return user.converted(to: UnitLength.meters)
        case "km":
            return user.converted(to: UnitLength.kilometers)
        default:
            return user.converted(to: UnitLength.millimeters)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("enter a number", value: $userNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($enterFocus)
                } header: {
                    Text("Enter a number")
                }
                
                Section {
                    Picker("Pick your unit", selection: $selectedUnitYour) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose your unit")
                }
                
                Section {
                    Picker("Pick unit to convert", selection: $selectedUnitConvert) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose unit to convert")
                }
                
                Section {
                    Text("\(converting.value.formatted())")
                } header: {
                    Text("Final output")
                }
                
            }
            .navigationTitle("UnitConversion")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        enterFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

