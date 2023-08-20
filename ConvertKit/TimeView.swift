//
//  TimeView.swift
//  ConvertKit
//
//  Created by Miten Gajjar on 20/08/23.
//

import SwiftUI

enum TimeType : String, CaseIterable, Equatable{
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days  = "Days"
}

struct TimeView: View {
    @State private var firstValue:Double = 0.0;
    @State private var firstValueType: TimeType = .seconds
    
    @State private var secondValueType:TimeType = .seconds
    private var secondValue: Double {
        let normalisedValue = convertToSeconds(firstValue, from:firstValueType)
        
        return convertFromSeconds(normalisedValue, to: secondValueType)
    }
    
    @FocusState private var isKeyboardOpened:Bool;
    
    func convertToSeconds(_ value:Double, from type:TimeType) -> Double{
        switch type{
        case .seconds : value
        case .minutes : value * 60
        case .hours : value * 60 * 60
        case .days : value * 24 * 60 * 60
        }
    }
    
    func convertFromSeconds(_ value:Double, to type:TimeType) -> Double{
        switch type {
        case .seconds : value
        case .minutes : value / 60
        case .hours : (value / 60) / 60
        case .days : ((value / 60) / 60) / 60
        }
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section("First Value"){
                    TextField("Enter the first value",value: $firstValue,format: .number)
                        .focused($isKeyboardOpened)
                    Picker("Select value type",selection: $firstValueType){
                        ForEach(TimeType.allCases,id:\.self){
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Second Value"){
                    Text(secondValue,format: .number)
                    Picker("Select value type",selection: $secondValueType){
                        ForEach(TimeType.allCases,id:\.self){
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
        .navigationTitle("Time Convertor")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TimeView()
}
