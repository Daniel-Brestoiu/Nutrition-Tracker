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
    
    var body: some View {
        //let screenRect = UIScreen.main.bounds
        //let screenWidth = screenRect.width
        //let screenHeight = screenRect.height
        let textColor = hexToUIColor(hex: "0008ff")
        //let bgColor = hexToUIColor(hex: "#C1E5FF")
        //let bgColor = hexToUIColor(hex: "#edf6ff")
        
        NavigationView{
            
            ZStack{
                LinearGradient(gradient: Gradient(colors:[.white, .blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                HStack{
                    NavigationLink(destination: SecondPage(), tag: "Home", selection: $page) {}
                    NavigationLink(destination: Text("Settings page"), tag: "Settings", selection: $page) {}
                        
                        .navigationBarItems(
                            leading:
                                Button("Home"){
                                    self.page = "Home"
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
                    PieChartView(data: [5,10],
                                 title: "Calories Consumed")
                        .frame(width:250, height: 250 )
                    
                    Spacer()
                    
                    VStack{
                        NavigationLink(destination: Text("Manual Input page"), tag: "Manual Input", selection: $page) {EmptyView()}
                        NavigationLink(destination: Text("Fast Food Input page"), tag: "Fast Food Input", selection: $page) {EmptyView()}
                        NavigationLink(destination: Text("Statistics page"), tag: "Statistics", selection: $page) {EmptyView()}
                        
                        Button("Manual Input"){
                            self.page = "Manual Input"
                        }
                        .frame(width: 200, height:20)
                        .padding(.bottom, 15)
                        
                        Button("Food Automatic Input"){
                            self.page = "Fast Food Input"
                        }
                        .frame(width: 200, height:20)
                        .padding(.bottom, 15)
                        
                        
                        Button("Statistics"){
                            self.page = "Statistics"
                        }
                        .frame(width: 200, height:20)
                        .padding(.bottom, 50)
                    }
                    
                    
                    
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

