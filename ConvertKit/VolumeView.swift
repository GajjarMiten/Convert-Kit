//
//  VolumeView.swift
//  ConvertKit
//
//  Created by Miten Gajjar on 20/08/23.
//

import SwiftUI

enum VolumeType : String,CaseIterable,Equatable{
    case milliliters = "Milliliters"
    case liters = "Liters"
    case cups = "Cups"
    case pints  = "Pints"
    case gallons = "Gallons"
}


struct VolumeView: View {
    @State private var firstValue = 0.0;
    @State private var firstValueType:VolumeType = .milliliters
    
    @State private var secondValueType: VolumeType = .milliliters;
    private var secondValue:Double{
        let normalisedValue = convertToMilli(firstValue, from: firstValueType)
        return convertFromMilli(normalisedValue, to: secondValueType);
    }
    
    func convertToMilli(_ value:Double, from type:VolumeType)-> Double{
        switch type {
        case .milliliters : value
        case .liters : value * 1000
        case .cups : value * 236.588
        case .pints : value * 473.2
        case .gallons : value * 3785
        }
    }
    
    func convertFromMilli(_ value:Double, to type:VolumeType)-> Double{
        switch type {
        case .milliliters : value
        case .liters : value / 1000
        case .cups : value / 236.588
        case .pints : value / 473.2
        case .gallons : value / 3785
        }
    }
    
    @FocusState private var isKeyboardOpened : Bool;

    var body: some View {
        NavigationView{
            
            Form {
                Section("First value") {
                    TextField("Enter first value",value:$firstValue,format: .number)
                        .focused($isKeyboardOpened)
                    Picker("Select value type",selection: $firstValueType){
                        ForEach(VolumeType.allCases,id:\.self){
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Second value"){
                    Text(secondValue, format: .number);
                    Picker("Select value type",selection: $secondValueType){
                        ForEach(VolumeType.allCases,id:\.self){
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
            .navigationTitle("Volume convertor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    VolumeView()
}
