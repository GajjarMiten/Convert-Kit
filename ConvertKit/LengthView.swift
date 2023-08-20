//
//  LengthView.swift
//  ConvertKit
//
//  Created by Miten Gajjar on 20/08/23.
//

import SwiftUI

enum LenghtType : String,CaseIterable,Equatable{
    case meter = "Meter"
    case kilometer = "Kilometer"
    case feet = "Feet"
    case yards = "Yards"
    case miles = "Miles"
}



struct LengthView: View {
    @State private var firstValue = 0.0;
    @State private var firstValueType:LenghtType = .meter
    
    @State private var secondValueType:LenghtType = .meter
    var secondValue: Double{
        let normalisedValue = convertToMeter(firstValue, from: firstValueType)
        return convertFromMeter(normalisedValue, to: secondValueType);
    }
    
    func convertToMeter(_ value:Double, from type:LenghtType) -> Double{
        switch type {
        case .meter : value
        case .kilometer : value * 1000
        case .feet : value / 3.2804
        case .yards : value / 1.094
        case .miles : value * 1609
        }
    }
    
    func convertFromMeter(_ value:Double, to type:LenghtType) -> Double{
        switch type {
        case .meter : value
        case .kilometer : value / 1000
        case .feet : value * 3.2804
        case .yards : value * 1.094
        case .miles : value / 1609
        }
    }
    
    @FocusState private var isKeyboardOpened:Bool;
    var body: some View {
        NavigationView{
            Form{
                Section("First Value"){
                    TextField("Enter first value",value: $firstValue,format: .number)
                        .focused($isKeyboardOpened)
                    Picker("Select value type",selection: $firstValueType){
                        ForEach(LenghtType.allCases,id:\.self){
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Second Value"){
                    Text(secondValue,format: .number)
                    Picker("Select value type",selection: $secondValueType){
                        ForEach(LenghtType.allCases,id:\.self){
                            Text($0.rawValue)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        isKeyboardOpened = false
                    }
                }
            }
        }
        
        .navigationTitle("Length Convertor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LengthView()
}
