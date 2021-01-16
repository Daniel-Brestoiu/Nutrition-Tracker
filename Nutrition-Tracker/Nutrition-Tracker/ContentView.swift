//
//  ContentView.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-16.
//

import SwiftUI



struct ContentView: View {
    @State private var page: String? = nil
    
    var body: some View {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.width
        let screenHeight = screenRect.height
        
        NavigationView{
            let bgColor = hexToUIColor(hex: "#C1E5FF")
            Color(bgColor)
                .ignoresSafeArea()
                .overlay(
                        ZStack{

                            
                            HStack(){
                                NavigationLink(destination: Text("Home page"), tag: "Home", selection: $page) {EmptyView()}
                                NavigationLink(destination: Text("History page"), tag: "History", selection: $page) {EmptyView()}
                                NavigationLink(destination: Text("Settings page"), tag: "Settings", selection: $page) {EmptyView()}
                                NavigationLink(destination: Text("Manual Input page"), tag: "Manual Input", selection: $page) {EmptyView()}
                                
                                
                                Button("Home"){
                                    self.page = "Home"
                                }
                                .padding(.trailing, 5)
                                
                                Button("History"){
                                    self.page = "History"
                                }
                                .padding(.trailing, 5)
                                
                                Button("Settings"){
                                    self.page = "Settings"
                                }
                                .padding(.trailing, 5)
                                
                                Button("Manual Input"){
                                    self.page = "Manual Input"
                                }
                                .padding(.trailing, 5)
                            }
                            .frame(width: screenWidth, height: screenHeight, alignment: .top)
                            //.background(Color.red)

                            ZStack{
                                VStack(alignment: .center){
                                    let textColor = hexToUIColor(hex: "0008ff")
                                    
                                    Text("Nutrition Tracker")
                                        .font(.title)
                                        .foregroundColor(Color(textColor))
                                    Text("Calories Today:")
                                        .foregroundColor(Color(textColor))

                                }
                            }
                        }
                )
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
