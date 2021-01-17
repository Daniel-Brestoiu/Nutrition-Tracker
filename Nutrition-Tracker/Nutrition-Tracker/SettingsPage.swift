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
    @State private var page: String? = nil
    @State var desiredDailyCalories:Double = 0
    @State var inputDesiredDailyCalories: String = ""
    
    @State private var calories: Int = 0
    
    @State var caloriesRemainingToday: Double = 2200.0
    @State var caloriesToday: Double = 0.0
    
    var body: some View{
        ZStack{
            Form{
                VStack{
                    HStack{
                        Text("Desired Daily Number of Calories:")
                            .font(.callout)
                            .bold()
                        
                        TextField("Calories", text: $inputDesiredDailyCalories)
                            .multilineTextAlignment(.trailing)
                            .onReceive(Just(inputDesiredDailyCalories)){
                                newValue in
                                let filtered = newValue.filter{"0123456789".contains($0)}
                                if filtered != newValue{
                                    self.inputDesiredDailyCalories = filtered
                                }
                            }
                    }
                    Divider()
                    Button("Submit"){
                        let encodedCalories = (inputDesiredDailyCalories as NSString).doubleValue
                        let newDesiredDailyCalories:Double = encodedCalories
                        print(newDesiredDailyCalories)
                        
                        inputDesiredDailyCalories = ""
                    }
                }

            }
            //Previous desired calories per day minus calories remaining today = calories consumed today
            // Tkae new desiredDailyCalories and subtract calories consumed today
            PieChartView(data: [caloriesToday, caloriesRemainingToday],
                         title: "Calories Consumed")
                .frame(width:300, height: 300)
        }
    }
}

struct SettingsPage_Previews: PreviewProvider{
    static var previews: some View{
        SettingsPage()
    }
}
