//
//  SettingsPage.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-16.
//

import Foundation
import SwiftUI
import Combine
import SwiftUICharts


struct SettingsPage: View{
    @State var desiredDailyCalories:Double = 0
    @State var inputDesiredDailyCalories: String = ""
    
    var body: some View{
        
        ZStack{
            Form{
                    Section(header:Text("Daily Calorie Settings")){
                        VStack{
                            HStack{
                                Text( "Number of Daily Calories:")
                                    .font(.callout)
                                    .bold()
                                
                                TextField("Calories", text: $inputDesiredDailyCalories)
                                    .multilineTextAlignment(.trailing)
                                    .onReceive(Just(inputDesiredDailyCalories)){
                                        newValue in
                                        let filtered = newValue.filter{"0123456789".contains($0)}
                                        if filtered != newValue{
                                            let first8 = String(filtered.prefix(8))
                                            self.inputDesiredDailyCalories = first8
                                        }
                                        if newValue.count > 8{
                                            let first8 = String(filtered.prefix(8))
                                            self.inputDesiredDailyCalories = first8
                                        }
                                    }
                            }
                            Divider()
                            
                            VStack{
                                    Button("Submit"){
                                        let newDailyCalories = (inputDesiredDailyCalories as NSString).doubleValue
                                        let currentEatenCalories = Double(getCaloriesConsumedToday())
                                        
                                        if newDailyCalories != Double(0){
                                            setCaloriesPerDay(input: newDailyCalories)
                                            setCaloriesRemainingToday(input: (newDailyCalories - currentEatenCalories))
                                        }
                                        
                                        inputDesiredDailyCalories = ""
                                        print("Submitted")
                                    }
                            }
                        }
                        
                    }
                    
                    
                
                    
                    Section(header:Text("New Day Controls")){
                        Button("Reset Calories"){
                            setCaloriesConsumedToday(input: Double(0.0))
                            setCaloriesRemainingToday(input: Double(2200.0))
                            setCaloriesPerDay(input: Double(2200.0))
                            print("reseted")
                        }
                    }
                }
            
            
        }
    }
    
}


struct SettingsPage_Previews: PreviewProvider{
    static var previews: some View{
        SettingsPage()
    }
}
