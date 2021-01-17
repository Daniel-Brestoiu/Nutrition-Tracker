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
    
    let caloriesPerDay: Double = 2200.0
    
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
                            .onReceive(Just(calories)){
                                newValue in
                                let filtered = newValue.filter{"0123456789".contains($0)}
                                if filtered != newValue{
                                    self.calories = filtered
                                }
                            }
                    }
                    Divider()
                    
                    Button("Submit"){
                        let currentDayTime = Date()
                        
                        
                        let encodedCalories = (calories as NSString).doubleValue
                        let newCalories:Double = encodedCalories
                        
                        caloriesToday += newCalories
                        caloriesRemainingToday -= newCalories
                        
                        
                        //Logic for actually recording this information
                        print(currentDayTime)
                        print(foodItem)
                        print(calories)
                        
                        foodItem = ""
                        calories = ""
                    }
                }
            }
            PieChartView(data: [caloriesToday, caloriesRemainingToday],
                         title: "Calories Consumed")
                .frame(width:300, height: 300)

            
            
            
        }
        
    }
    
    
}



struct ManualInputPage_Previews: PreviewProvider{
    static var previews: some View{
        ManualInputPage()
    }
}
