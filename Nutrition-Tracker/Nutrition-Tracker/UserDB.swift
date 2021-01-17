//
//  UserDB.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-17.
//


// Table1: Daily Necessities = calories, caloriesRemainingToday, caloriesToday, caloriesPerDay, desiredDailyCalories,


import Foundation
import SQLite

let CurrentUserInfo = Table("CurrentUserInfo")
let UserHistory = Table("UserHistory")

let caloriesRemainingToday = Expression<Int64>("caloriesRemainingToday")
let caloriesConsumedToday = Expression<Int64>("caloriesConsumedToday")
let caloriesPerDay = Expression<Double>("caloriesPerDay")

//Second database
let dateEaten = Expression<String>("date")
let foodEaten = Expression<String>("food")
let foodCalories = Expression<String>("foodCalories")

func openDatabase() -> Connection? {
    do{
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        let db = try Connection("\(path)/db.sqlite3")
        return db
    }
    catch{
        print("No db")
        return nil}
}

func initDatabase() -> Void{
    let maybeDB = openDatabase()
    
    
    
    if let db = maybeDB{
        do{
            try db.run(UserHistory.create { t in     // CREATE TABLE "CurrentUserInfo" (
                t.column(dateEaten)   //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(foodEaten)                     //     "email" TEXT UNIQUE NOT NULL,
                t.column(foodCalories)                  //     "name" TEXT
            })
            
            try db.run(CurrentUserInfo.create { t in     // CREATE TABLE "CurrentUserInfo" (
                t.column(caloriesRemainingToday, primaryKey: true) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(caloriesConsumedToday, unique: true)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(caloriesPerDay)                 //     "name" TEXT
            })
            
            defaultPopulateDB()
        }
        catch{}
    }else{}
    
    
    //if tables not exist, do nothing
    //else create tables emptily
}

func defaultPopulateDB() ->Void {
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            try db.run(CurrentUserInfo.insert(caloriesRemainingToday <- 2200, caloriesPerDay <- 2200, caloriesConsumedToday <- 0))
        }
        catch{}
    }else{}
}

func getCaloriesRemainingToday() -> Int64{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            for userInfo in try db.prepare(CurrentUserInfo){
                return userInfo[caloriesRemainingToday]
            }
        }
        catch{}
    }else{}
    
    return -1
}

func getCaloriesConsumedToday() -> Int64{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            for userInfo in try db.prepare(CurrentUserInfo){
                return userInfo[caloriesConsumedToday]
            }
        }
        catch{}
    }else{}
    
    return -1
}
func getCaloriesPerDay() -> Double{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            for userInfo in try db.prepare(CurrentUserInfo){
                return userInfo[caloriesPerDay]
            }
        }
        catch{}
    }else{}
    
    return -1
}

func setCaloriesRemainingToday(input:Double) -> Void{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            
            try db.run(CurrentUserInfo.update(caloriesRemainingToday <- Int64(input)))
            
        }
        catch{}
    }else{}
    
}
func setCaloriesConsumedToday(input:Double) -> Void{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            
            try db.run(CurrentUserInfo.update(caloriesConsumedToday <- Int64(input)))
            
        }
        catch{}
    }else{}
    
}
func setCaloriesPerDay(input:Double) -> Void{
    let maybeDB = openDatabase()
    
    if let db = maybeDB{
        do{
            
            try db.run(CurrentUserInfo.update(caloriesPerDay <- input))
            
        }
        catch{}
    }else{}
    
}
