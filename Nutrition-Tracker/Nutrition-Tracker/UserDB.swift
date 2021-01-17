//
//  UserDB.swift
//  Nutrition-Tracker
//
//  Created by Daniel Brestoiu on 2021-01-17.
//

import Foundation
import SQLite

func openDatabase() -> Connection? {
    do{
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        let db = try Connection("\(path)/db.sqlite3")
        
        print("got dB")
        return db
    }
    catch{
        print("No db")
        return nil}
  }

