//
//  ContentView.swift
//  BetterRest
//
//  Created by Sandra Gomez on 6/19/25.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showAlert = false
    var idealBedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Sorry there was a problem calculating your bedtime"
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    //                VStack(alignment: .leading, spacing: 0) {
                    Text ("When do you want to wake up")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    Text("Desired Amount of Sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
//                    Text("Daily Coffee Intake")
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    Picker ("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                }
                Section {
                    Text("Your ideal bedtime is")
                        .font(.headline)
                    Text(idealBedtime)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Better Rest")
//            .alert(alertTitle, isPresented: $showAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
//    func calculateBedtime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//            
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//            
//            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
//            
//            let sleepTime = wakeUp - prediction.actualSleep
//            return sleepTime.formatted(date: .omitted, time: .shortened)
//            
//        } catch {
//            return "Sorry there was a problem calculating your bedtime"
//        }
//    }
//                
//                
                
//                alertTitle = "Your ideal bedtime is..."
//                alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            } catch {
//                alertTitle = "Error"
//                alertMessage = "Sorry, there was a problem calculating your bedtime"
//            }
//            showAlert = true
        }
    

#Preview {
    ContentView()
}
