//
//  ManualInputPage.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-16.
//

import SwiftUICharts
import Foundation
import SwiftUI
import Combine

struct ManualInputPage: View {
    @State var foodItem: String = ""
    @State var calories: String = ""
    @State var desiredDailyCalories:Double = 0
    @State var inputDesiredDailyCalories: String = ""
    
    @State var caloriesGoalPerDay: Double = 2200.0
    
    @State var caloriesRemainingToday: Double = 2200.0
    @State var caloriesToday: Double = 0.0
    
    
    
    var body: some View{
               // let screenRect = UIScreen.main.bounds
                //let screenWidth = screenRect.width
                //let screenHeight = screenRect.height
        
        ZStack(){
            Form{
                VStack{
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                        Text("Food Item:")
                            .font(.callout)
                            .bold()
                        
                        TextField("Food Name", text: $foodItem)
                            .multilineTextAlignment(.trailing)
                    }
                    Divider()
                    HStack{
                        Text("Number of Calories:")
                            .font(.callout)
                            .bold()
                        
                        TextField("Calories", text: $calories)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.default)
                            .onReceive(Just(calories)){
                                newValue in
                                let filtered = newValue.filter{"0123456789".contains($0)}
                                if filtered != newValue{
                                    let first6 = String(filtered.prefix(6))
                                    self.calories = first6
                                }
                                if newValue.count > 6{
                                    let first6 = String(filtered.prefix(6))
                                    self.calories = first6
                                }
                            }
                    }
                    Divider()
                    
                    Button("Submit"){
                        //let currentDayTime = Date()
                        
                        
                        let encodedCalories = (calories as NSString).doubleValue
                        let newCalories:Double = encodedCalories
                        
                        
                        caloriesToday += newCalories
                        caloriesRemainingToday -= newCalories
                        
                        
                        setCaloriesConsumedToday(input: caloriesToday)
                        setCaloriesRemainingToday(input: caloriesRemainingToday)
                        
                        
                        //Logic for actually recording this information
                        
                        foodItem = ""
                        calories = ""
                    }
                }
            }
            PieChartView(data: [caloriesToday, caloriesRemainingToday],
                         title: "Calories Consumed")
                .frame(width:300, height: 300)
                .padding(.top, 100)

            
            
            
        }
        .onAppear{
            caloriesRemainingToday = Double(getCaloriesRemainingToday())
            caloriesToday = Double(getCaloriesConsumedToday())
            caloriesGoalPerDay = Double(getCaloriesPerDay())
        }
        
    }
}



struct ManualInputPage_Previews: PreviewProvider{
    static var previews: some View{
        ManualInputPage()
    }
}

