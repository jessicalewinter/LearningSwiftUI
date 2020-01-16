//
//  ContentView.swift
//  BetterRest
//
//  Created by Jessica Lewinter on 15/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60 * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "Your ideal bedtime is:"
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            print("Prediction was not successful. Please try again")
            
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showAlert = true
    }

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(alertTitle)
                            .font(.headline)
                        Text(alertMessage)
                            .font(.largeTitle)
                    }.onAppear {
                        self.calculateBedTime()
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Cup of coffees spend:")
                            .font(.headline)
                        Picker(selection: $coffeeAmount, label: Text("Number of cups")) {
                            ForEach(0..<20) { cup in
                                cup == 1 ? Text("1 cup") : Text("\(cup) cups")
                            }
                        }
                    }
                }
                .navigationBarTitle("Better Rest")
            }
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
