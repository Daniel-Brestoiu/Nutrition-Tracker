//
//  ContentView.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-16.
//

import SwiftUICharts
import SwiftUI
import UIKit



struct ContentView: View {
    @State private var page: String? = nil
    @State private var calories: Int = 0
    
    @State var caloriesRemainingToday: Double = 2200.0
    @State var caloriesToday: Double = 0.0
    
    
    var body: some View {
        //let screenRect = UIScreen.main.bounds
        //let screenWidth = screenRect.width
        //let screenHeight = screenRect.height
        let textColor = hexToUIColor(hex: "0008ff")
        let brightTextColor = hexToUIColor(hex: "#7aa0ff")
        //let bgColor = hexToUIColor(hex: "#C1E5FF")
        //let bgColor = hexToUIColor(hex: "#edf6ff")
    
        
        NavigationView{
            
            ZStack{
                LinearGradient(gradient: Gradient(colors:[.white, .blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                HStack{
                    NavigationLink(destination: GoalManagementPage(), tag: "Goals", selection: $page) {}
                    NavigationLink(destination: SettingsPage(), tag: "Settings", selection: $page) {}
                        
                        .navigationBarItems(
                            leading:
                                Button("Goals"){
                                    self.page = "Goals"
                                },
                            trailing:
                                Button("Settings"){
                                    self.page = "Settings"
                                })
                }

                VStack(){
                    VStack(){
                        Text("Nutrition Tracker")
                            .font(.title)
                            .foregroundColor(Color(textColor))
                        Text("Calories Today: \(calories)")
                            .foregroundColor(Color(textColor))
                    }.padding(.top, 5)
                    .padding(.trailing, 15)
                
                    Spacer()
                    //Pi Chart
                    PieChartView(data: [caloriesToday,caloriesRemainingToday],
                                 title: "Calories Consumed")
                        .frame(width:300, height: 300)
                    
                    Spacer()
                    
                    VStack{
                        NavigationLink(destination: ManualInputPage(), tag: "Manual Input", selection: $page) {EmptyView()}
                        NavigationLink(destination: FoodAutomaticInputPage(), tag: "Fast Food Input", selection: $page) {EmptyView()}
                        NavigationLink(destination: StatisticsPage(), tag: "Statistics", selection: $page) {EmptyView()}
                        
                        Button("Manual Input"){
                            self.page = "Manual Input"
                        }
                        .frame(width: 200, height:20)
                        .foregroundColor(Color(brightTextColor))
                        .padding(.bottom, 15)
                        
                        Button("Food Automatic Input"){
                            self.page = "Fast Food Input"
                        }
                        .frame(width: 200, height:20)
                        .foregroundColor(Color(brightTextColor))
                        .padding(.bottom, 15)
                        
                        
                        Button("Statistics"){
                            self.page = "Statistics"
                        }
                        .frame(width: 200, height:20)
                        .foregroundColor(Color(brightTextColor))
                        .padding(.bottom, 50)
                    }
                    Spacer()
                }
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

func hexToUIColor(hex:String) -> UIColor{
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#"){
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6){
        return UIColor.white
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
