//
//  TemperatureView.swift
//  ConvertKit
//
//  Created by Miten Gajjar on 20/08/23.
//

import SwiftUI

enum TemperatureType : String, CaseIterable,Equatable{
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kevlin = "Kelvin"
}



struct TemperatureView: View {
    
    @State private var firstValue = 0.0;
    @State private var firstValueType: TemperatureType = .celsius;
    
    
    @State private var secondValueType: TemperatureType = .celsius;
    
    @FocusState private var isKeyboardOpened:Bool;
    
    private var secondValue:Double {
        let normalisedValue = convertToCelsius(firstValue, from: firstValueType)
        return convertFromCelsius(normalisedValue, to: secondValueType);
    }
    
    
    func convertToCelsius(_ value:Double, from type:TemperatureType)-> Double{
        switch type {
        case .celsius : value
        case .fahrenheit : (value-32)*5/9
        case .kevlin : value - 273.15
        }
    }
    
    func convertFromCelsius(_ value:Double,to type:TemperatureType ) -> Double{
        switch type{
        case .celsius : value
        case .fahrenheit : (value*9/5)+32
        case .kevlin : value + 273.15
        }
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                Group{
                    Section("First Value"){
                        TextField("Enter first value", value :$firstValue, format: .number)
                            .focused($isKeyboardOpened)
                        
                        Picker("Select value type",selection:$firstValueType){
                            ForEach(TemperatureType.allCases,id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }
                    
                }
                Section("Second Value"){
                    Text(secondValue, format: .number)
                    
                    Picker("Select value type",selection:$secondValueType){
                        ForEach(TemperatureType.allCases,id: \.self){
                            Text($0.rawValue)
                        }
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
        .navigationTitle("Temperature Convertor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TemperatureView()
}
