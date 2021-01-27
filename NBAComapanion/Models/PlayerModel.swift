//
//  PlayerModel.swift
//  NBA Companion
//

import UIKit

class PlayerModel: Codable {

  var id: Int?
  var first_name: String?
  var last_name: String?
  var position: String?
  var height_feet: Int?
  var team: TeamModel?
}
