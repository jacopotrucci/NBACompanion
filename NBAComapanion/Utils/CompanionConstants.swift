//
//  CompanionConstants.swift
//  NBAComapanion
//

import Foundation

class CompanionConstants: NSObject {
  
  static var BASE_URL : String { return "https://free-nba.p.rapidapi.com" }
  
  static var NBA_TEAMS : String { return BASE_URL + "/teams"}
  static var NBA_PLAYERS : String { return BASE_URL + "/players"}  
}
