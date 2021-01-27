//
//  PlayerInfoViewController.swift
//  NBAComapanion
//

import UIKit

class PlayerInfoViewController: UIViewController {
  
  //----------------------------------------------------------------------------------------------------
  //  PUBLIC PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  var selectedPlayer: PlayerModel?
  
  //----------------------------------------------------------------------------------------------------
  //  PRIVATE PROPERTIES
  //----------------------------------------------------------------------------------------------------
  
  @IBOutlet private var playerName: UILabel!
  @IBOutlet private var playerPosition: UILabel!
  @IBOutlet private var playerTeam: UILabel!
  @IBOutlet private var playerFeet: UILabel!
  
  //----------------------------------------------------------------------------------------------------
  //  LIFETIME
  //----------------------------------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prime()
  }
  
  //----------------------------------------------------------------------------------------------------
  //  OTHERS
  //----------------------------------------------------------------------------------------------------

  func prime() {
    //bail out if model is nil
    guard selectedPlayer != nil else { return }
    
    playerName.text = "\(selectedPlayer?.first_name ?? "") \(selectedPlayer?.last_name ?? "")"
    playerPosition.text = selectedPlayer?.position ?? "--"
    playerTeam.text = selectedPlayer?.team?.full_name ?? "--"
    playerFeet.text = "\(selectedPlayer?.height_feet ?? 0)"
  }
}
